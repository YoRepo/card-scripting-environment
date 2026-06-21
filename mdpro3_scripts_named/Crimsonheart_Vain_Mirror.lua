--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-21T00:00:00
-- Card: Crimsonheart Vain Mirror  (ID: 211140)
-- Type: Monster / Effect / Fusion
-- Attribute: DARK
-- Race: Illusion
-- Level 3
-- ATK 0 | DEF 0
-- Setcode: 0x95c (Crimsonheart)
--
-- Materials: 1 "Crimsonheart" monster + 1 Effect monster
--
-- Effect Text:
-- You can Special Summon this card (from your Extra Deck) by Tributing 1 "Crimsonheart" monster you
-- control while you control "Barren Lady Lacrimosaica". You can only Special Summon "Crimsonheart
-- Vain Mirror(s)" once per turn.
-- (1) If this card is Special Summoned from the Extra Deck: You can target 1 Effect monster your
-- opponent controls; while this card remains face-up on the field, that target's effects are negated,
-- also it cannot be used as Fusion, Synchro, Xyz or Link material. If this card leaves the field,
-- destroy that monster. If that target leaves the field, destroy this card.
--[[ __CARD_HEADER_END__ ]]

--Crimsonheart Vain Mirror
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,211000)
	c:EnableReviveLimit()
	c:SetSPSummonOnce(id)
	--fusion material: 1 "Crimsonheart" monster + 1 Effect monster
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x95c),aux.FilterBoolFunction(Card.IsFusionType,TYPE_EFFECT),true)
	--alternative Special Summon: Tribute 1 "Crimsonheart" you control while you control Lacrimosaica
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_FIELD)
	e0:SetCode(EFFECT_SPSUMMON_PROC)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetRange(LOCATION_EXTRA)
	e0:SetCondition(s.spcon)
	e0:SetTarget(s.sptg)
	e0:SetOperation(s.spop)
	c:RegisterEffect(e0)
	--(1) if SS'd from Extra Deck: target 1 opp Effect monster; negate & lock as material while face-up
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_DISABLE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(s.discon)
	e1:SetTarget(s.distg)
	e1:SetOperation(s.disop)
	c:RegisterEffect(e1)
	--if this card leaves the field, destroy that monster
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetOperation(s.desop1)
	c:RegisterEffect(e2)
	--if that target leaves the field, destroy this card
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(s.descon2)
	e3:SetOperation(s.desop2)
	c:RegisterEffect(e3)
end
--alternative summon (Tribute 1 "Crimsonheart" while controlling Lacrimosaica)
function s.lacfilter(c)
	return c:IsFaceup() and c:IsCode(211000)
end
function s.spfilter(c,tp,sc)
	return c:IsSetCard(0x95c) and Duel.GetLocationCountFromEx(tp,tp,c,sc)>0
end
function s.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.IsExistingMatchingCard(s.lacfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.CheckReleaseGroupEx(tp,s.spfilter,1,REASON_SPSUMMON,false,nil,tp,c)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetReleaseGroup(tp,false,REASON_SPSUMMON):Filter(s.spfilter,nil,tp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local tc=g:SelectUnselect(nil,tp,false,true,1,1)
	if tc then
		e:SetLabelObject(tc)
		return true
	else return false end
end
function s.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	Duel.Release(g,REASON_SPSUMMON)
end
--(1)
function s.discon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonLocation(LOCATION_EXTRA)
end
function s.tgfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_EFFECT)
end
function s.distg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and s.tgfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(s.tgfilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISABLE)
	local g=Duel.SelectTarget(tp,s.tgfilter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,g,1,0,0)
end
function s.ctcon(e)
	return e:GetOwner():IsHasCardTarget(e:GetHandler())
end
function s.fuslimit(e,c,sumtype)
	return sumtype==SUMMON_TYPE_FUSION
end
function s.disop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not (c:IsRelateToEffect(e) and tc and tc:IsRelateToChain() and tc:IsControler(1-tp) and tc:IsFaceup()) then return end
	c:SetCardTarget(tc)
	--negate its effects (while this card remains face-up)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	e1:SetCondition(s.ctcon)
	tc:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_DISABLE_EFFECT)
	e2:SetValue(RESET_TURN_SET)
	e2:SetReset(RESET_EVENT+RESETS_STANDARD)
	e2:SetCondition(s.ctcon)
	tc:RegisterEffect(e2)
	--cannot be used as Fusion/Synchro/Xyz/Link material (while this card remains face-up)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_IGNORE_IMMUNE)
	e3:SetCode(EFFECT_CANNOT_BE_FUSION_MATERIAL)
	e3:SetRange(LOCATION_MZONE)
	e3:SetReset(RESET_EVENT+RESETS_STANDARD)
	e3:SetValue(s.fuslimit)
	e3:SetCondition(s.ctcon)
	tc:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	e4:SetValue(1)
	tc:RegisterEffect(e4)
	local e5=e3:Clone()
	e5:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	e5:SetValue(1)
	tc:RegisterEffect(e5)
	local e6=e3:Clone()
	e6:SetCode(EFFECT_CANNOT_BE_LINK_MATERIAL)
	e6:SetValue(1)
	tc:RegisterEffect(e6)
end
--if this card leaves the field, destroy the target monster
function s.desop1(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetFirstCardTarget()
	if tc and tc:IsLocation(LOCATION_MZONE) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
--if the target leaves the field, destroy this card
function s.descon2(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetFirstCardTarget()
	return tc and eg:IsContains(tc)
end
function s.desop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
