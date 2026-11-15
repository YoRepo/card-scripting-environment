--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-11-15T00:00:00
-- Card: Ink-Shader's Jar of Malevolence  (ID: 99811090)
-- Type: Trap / Normal
-- Setcode: 0x961 (Ink-Shade)
--
-- Effect Text:
-- If your opponent controls no monsters, you can activate this card from your hand. You can only use
-- each effect of "Ink-Shader's Jar of Malevolence" once per turn.
-- ① Send 1 "Ink-Shade" Spell/Trap from your hand to the GY; Look at your opponent's hand, then you can
-- Special Summon 1 monster from their hand to their field, but negate its effects.
-- ② If this card is in your GY: You can banish this card, then target 1 face-up monster your opponent
-- controls; equip it to an "Ink Shader" monster you control as an Equip Spell that gives it that
-- monster's original effects on the field.
--[[ __CARD_HEADER_END__ ]]

--Ink-Shader's Jar of Malevolence
local s,id,o=GetID()
function s.initial_effect(c)
	--(1) send 1 "Ink-Shade" Spell/Trap from hand to GY; look at your opponent's hand, then you can Special Summon
	--1 monster from their hand to their field, but negate its effects
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_TOHAND+TIMING_END_PHASE)
	e1:SetCountLimit(1,id)
	e1:SetCost(s.cost)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
	--if your opponent controls no monsters, you can activate this card from your hand (cf. Infinite Impermanence)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,3))
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	e2:SetCondition(s.handcon)
	c:RegisterEffect(e2)
	--(2) from GY: banish this card, then target 1 face-up monster your opponent controls; equip it to an "Ink Shader"
	--monster you control as an Equip Spell that gives it that monster's original effects
	--(a Trap's effect in the GY is Spell Speed 2: cf. Artmage Pact -Awakening-, Crimsonheart Thorns)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,1))
	e3:SetCategory(CATEGORY_EQUIP)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e3:SetCountLimit(1,id+o)
	e3:SetCost(aux.bfgcost)
	e3:SetTarget(s.eqtg)
	e3:SetOperation(s.eqop)
	c:RegisterEffect(e3)
end
function s.handcon(e)
	return Duel.GetFieldGroupCount(e:GetHandlerPlayer(),0,LOCATION_MZONE)==0
end
--(1)
function s.costfilter(c)
	return c:IsSetCard(0x961) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToGraveAsCost()
end
function s.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(s.costfilter,tp,LOCATION_HAND,0,1,c) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,s.costfilter,tp,LOCATION_HAND,0,1,1,c)
	Duel.SendtoGrave(g,REASON_COST)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 end
end
--Special Summoned by you, to your opponent's field (cf. Branded Expulsion)
function s.spfilter(c,e,tp)
	return c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP,1-tp)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if #g==0 then return end
	Duel.ConfirmCards(tp,g)
	local sg=g:Filter(s.spfilter,nil,e,tp)
	if #sg>0 and Duel.GetLocationCount(1-tp,LOCATION_MZONE,tp)>0
		and Duel.SelectYesNo(tp,aux.Stringid(id,2)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tc=sg:Select(tp,1,1,nil):GetFirst()
		--"but negate its effects" (cf. Artmage Peripeteia -Turmoil-)
		if Duel.SpecialSummonStep(tc,0,tp,1-tp,false,false,POS_FACEUP) then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_DISABLE)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			tc:RegisterEffect(e1)
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_DISABLE_EFFECT)
			e2:SetValue(RESET_TURN_SET)
			e2:SetReset(RESET_EVENT+RESETS_STANDARD)
			tc:RegisterEffect(e2)
		end
		Duel.SpecialSummonComplete()
	end
	Duel.ShuffleHand(1-tp)
end
--(2)
--an opponent's monster that can leave their field to become your Equip Spell (cf. Thousand-Eyes Restrict);
--a Token cannot become an Equip Spell
function s.tgfilter(c)
	return c:IsFaceup() and not c:IsType(TYPE_TOKEN) and c:IsAbleToChangeControler()
end
function s.eqfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x960)
end
function s.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and s.tgfilter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingMatchingCard(s.eqfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingTarget(s.tgfilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,s.tgfilter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,g,1,0,0)
end
function s.eqlimit(e,c)
	return c==e:GetLabelObject()
end
function s.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToChain() or tc:IsFacedown() or not tc:IsControler(1-tp) then return end
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	--the "Ink Shader" monster is not targeted: it is chosen on resolution
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectMatchingCard(tp,s.eqfilter,tp,LOCATION_MZONE,0,1,1,nil)
	local ec=g:GetFirst()
	if not ec then return end
	Duel.HintSelection(g)
	if not Duel.Equip(tp,tc,ec) then return end
	--equip limit (cf. Armored Xyz)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EFFECT_EQUIP_LIMIT)
	e1:SetLabelObject(ec)
	e1:SetValue(s.eqlimit)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	tc:RegisterEffect(e1)
	--"an Equip Spell that gives it that monster's original effects": the equipped monster copies them
	--(cf. Emperor Charles the Great). They are the Equip Spell's gift, so they last only while it stays equipped to
	--that monster and is not negated. The Equip Spell remembers the copy it is giving in a flag label (0 = none now)
	if tc:GetOriginalType()&TYPE_EFFECT~=0 then
		local cid=ec:CopyEffect(tc:GetOriginalCode(),RESET_EVENT+RESETS_STANDARD)
		tc:RegisterFlagEffect(id,RESET_EVENT+RESETS_STANDARD,0,1,cid)
		--taken back the moment the Equip Spell is sent off the field (cf. Graydle Cobra)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetCode(EVENT_LEAVE_FIELD_P)
		e2:SetLabelObject(ec)
		e2:SetOperation(s.lvop)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e2)
		--kept in step at every adjust: taken back for good once that card is no longer this monster's Equip Spell by
		--a route the event above does not see (moved, Special Summoned or attached from the Spell & Trap Zone, flipped
		--face-down), taken back while that card is negated, given again when the negation ends
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e3:SetCode(EVENT_ADJUST)
		e3:SetRange(LOCATION_MZONE)
		e3:SetLabel(cid)
		e3:SetLabelObject(tc)
		e3:SetOperation(s.adjop)
		e3:SetReset(RESET_EVENT+RESETS_STANDARD)
		ec:RegisterEffect(e3)
	end
end
function s.lvop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler()
	local cid=tc:GetFlagEffectLabel(id)
	if cid and cid~=0 then
		e:GetLabelObject():ResetEffect(cid,RESET_COPY)
		tc:SetFlagEffectLabel(id,0)
	end
end
--negated by anything except an effect the equipped monster itself applies: a copied effect that negates Spells
--(Spell Canceller's, say) must not make the copy drop and come back at every adjust
function s.isneg(tc,ec)
	if not tc:IsDisabled() then return false end
	for _,te in ipairs({tc:IsHasEffect(EFFECT_DISABLE)}) do
		if te:GetOwner()~=ec then return true end
	end
	return false
end
function s.adjop(e,tp,eg,ep,ev,re,r,rp)
	local ec=e:GetHandler()
	local tc=e:GetLabelObject()
	local cid=e:GetLabel()
	if tc:GetEquipTarget()~=ec or tc:IsFacedown() then
		--no longer this monster's Equip Spell (a copy id is never reused, so a second reset of one is harmless)
		if cid~=0 then ec:ResetEffect(cid,RESET_COPY) end
		e:Reset()
	elseif s.isneg(tc,ec) then
		if cid~=0 then
			ec:ResetEffect(cid,RESET_COPY)
			e:SetLabel(0)
			tc:SetFlagEffectLabel(id,0)
		end
	elseif cid==0 then
		cid=ec:CopyEffect(tc:GetOriginalCode(),RESET_EVENT+RESETS_STANDARD)
		e:SetLabel(cid)
		tc:SetFlagEffectLabel(id,cid)
	end
end
