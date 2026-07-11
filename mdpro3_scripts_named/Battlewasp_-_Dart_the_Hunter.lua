--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Battlewasp - Dart the Hunter  (ID: 91283212)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Insect
-- Level: 1
-- ATK 100 | DEF 100
-- Setcode: 0x12f
-- Scope: OCG / TCG
--
-- Effect Text:
-- When your "Battlewasp" monster destroys a monster by battle that is owned by your opponent: You can
-- discard this card; inflict damage to your opponent equal to that destroyed monster's original ATK.
-- You can target 1 other Insect monster you control; it is treated as a Tuner this turn, also you
-- cannot Special Summon from the Extra Deck for the rest of this turn, except Insect monsters.
-- You can only use each effect of "Battlewasp - Dart the Hunter" once per turn.
--[[ __CARD_HEADER_END__ ]]

--B・F－追撃のダート
function c91283212.initial_effect(c)
	--damge
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLED)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,91283212)
	e1:SetCondition(c91283212.damcon)
	e1:SetCost(c91283212.damcost)
	e1:SetTarget(c91283212.damtg)
	e1:SetOperation(c91283212.damop)
	c:RegisterEffect(e1)
	--change tuner
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,91283213)
	e2:SetTarget(c91283212.target)
	e2:SetOperation(c91283212.operation)
	c:RegisterEffect(e2)
end
function c91283212.damcon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not d then return false end
	if d:IsControler(tp) then a,d=d,a end
	return a:IsSetCard(0x12f) and d:IsStatus(STATUS_BATTLE_DESTROYED) and d:GetOwner()==1-tp
end
function c91283212.damcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsDiscardable() end
	Duel.SendtoGrave(c,REASON_COST+REASON_DISCARD)
end
function c91283212.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not d then return false end
	if d:IsControler(tp) then a,d=d,a end
	local atk=d:GetBaseAttack()
	if atk<0 then atk=0 end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(atk)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,atk)
end
function c91283212.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
function c91283212.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_INSECT) and not c:IsType(TYPE_TUNER)
end
function c91283212.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c91283212.filter(chkc) and chkc~=e:GetHandler() end
	if chk==0 then return Duel.IsExistingTarget(c91283212.filter,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c91283212.filter,tp,LOCATION_MZONE,0,1,1,e:GetHandler())
end
function c91283212.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_ADD_TYPE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(TYPE_TUNER)
		tc:RegisterEffect(e1)
	end
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,0)
	e2:SetTarget(c91283212.splimit)
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)
end
function c91283212.splimit(e,c)
	return not c:IsRace(RACE_INSECT) and c:IsLocation(LOCATION_EXTRA)
end
