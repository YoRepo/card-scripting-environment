--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Defect Compiler  (ID: 92327802)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Cyberse
-- Level: 3
-- ATK 1000 | DEF 1000
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn, if you would take damage from an opponent's card effect, place 1 Defect Counter on
-- this card instead (max. 1).
-- Once per turn (Quick Effect): You can remove 1 Defect Counter from this card, then target 1 Cyberse
-- monster you control; it gains 800 ATK until the end of this turn.
--[[ __CARD_HEADER_END__ ]]

--ディフェクト・コンパイラー
function c92327802.initial_effect(c)
	c:EnableCounterPermit(0x43)
	c:SetCounterLimit(0x43,1)
	--damage reduce
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_REPLACE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(1,0)
	e1:SetValue(c92327802.damval)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetDescription(aux.Stringid(92327802,1))
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetHintTiming(TIMING_DAMAGE_STEP)
	e2:SetCountLimit(1)
	e2:SetCondition(aux.dscon)
	e2:SetCost(c92327802.cost)
	e2:SetTarget(c92327802.tg)
	e2:SetOperation(c92327802.op)
	c:RegisterEffect(e2)
end
function c92327802.damval(e,re,val,r,rp,rc)
	local c=e:GetHandler()
	if bit.band(r,REASON_EFFECT)~=0 and rp==1-e:GetOwnerPlayer()
		and c:IsCanAddCounter(0x43,1) and c:GetFlagEffect(92327802)==0 then
		c:AddCounter(0x43,1)
		c:RegisterFlagEffect(92327802,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1)
		return 0
	end
	return val
end
function c92327802.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x43,1,REASON_COST) end
	Duel.RemoveCounter(tp,1,0,0x43,1,REASON_COST)
end
function c92327802.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_CYBERSE)
end
function c92327802.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c92327802.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c92327802.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c92327802.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c92327802.op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(800)
		tc:RegisterEffect(e1)
	end
end
