--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 风魔女-冻铃  (ID: 20246864)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Spellcaster
-- Level 3
-- ATK 1200 | DEF 1200
-- Setcode: 240
--
-- Effect Text:
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：自己场上的怪兽只有「风魔女」怪兽的场合才能发动。这张卡从手卡特殊召唤。
-- ②：1回合1次，自己主要阶段才能发动。这张卡的等级上升1星。
-- ③：用这张卡为同调素材把风属性同调怪兽同调召唤的场合，那只同调怪兽不会被战斗破坏。
--[[ __CARD_HEADER_END__ ]]

--WW－フリーズ・ベル
function c20246864.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(20246864,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,20246864)
	e1:SetCondition(c20246864.spcon)
	e1:SetTarget(c20246864.sptg)
	e1:SetOperation(c20246864.spop)
	c:RegisterEffect(e1)
	--level up!
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(20246864,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c20246864.lvtg)
	e2:SetOperation(c20246864.lvop)
	c:RegisterEffect(e2)
	--effect
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_BE_MATERIAL)
	e3:SetProperty(EFFECT_FLAG_EVENT_PLAYER)
	e3:SetCondition(c20246864.efcon)
	e3:SetOperation(c20246864.efop)
	c:RegisterEffect(e3)
end
function c20246864.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xf0)
end
function c20246864.spcon(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_MZONE,0)
	return #g>0 and #g==Duel.GetMatchingGroupCount(c20246864.cfilter,tp,LOCATION_MZONE,0,nil)
end
function c20246864.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c20246864.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c20246864.lvtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsLevelAbove(1) end
end
function c20246864.lvop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
	end
end
function c20246864.efcon(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_SYNCHRO and e:GetHandler():GetReasonCard():IsAttribute(ATTRIBUTE_WIND)
end
function c20246864.efop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local rc=c:GetReasonCard()
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(20246864,2))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CLIENT_HINT)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(1)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	rc:RegisterEffect(e1,true)
end
