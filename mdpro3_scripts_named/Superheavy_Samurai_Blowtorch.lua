--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Superheavy Samurai Blowtorch  (ID: 7864030)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level: 1
-- ATK 500 | DEF 300
-- Setcode: 0x9a
-- Scope: OCG / TCG
--
-- Effect Text:
-- When an opponent's monster declares an attack while you have no Spell/Trap Cards in your Graveyard:
-- You can send this card from your hand to the Graveyard, then target 1 "Superheavy Samurai" monster
-- you control; change the attack target to it and perform damage calculation.
-- Once per turn, when an opponent's monster declares an attack: You can change the attack target to
-- this card and perform damage calculation.
-- Cannot be destroyed by battle.
--[[ __CARD_HEADER_END__ ]]

--超重武者タイマ－2
function c7864030.initial_effect(c)
	--change battle target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetRange(LOCATION_HAND)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c7864030.condition1)
	e1:SetCost(c7864030.cost)
	e1:SetTarget(c7864030.target1)
	e1:SetOperation(c7864030.operation1)
	c:RegisterEffect(e1)
	--change battle target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c7864030.condition2)
	e2:SetOperation(c7864030.operation2)
	c:RegisterEffect(e2)
	--indes
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e3:SetValue(1)
	c:RegisterEffect(e3)
end
function c7864030.condition1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and not Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_GRAVE,0,1,nil,TYPE_SPELL+TYPE_TRAP)
end
function c7864030.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c7864030.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x9a)
end
function c7864030.target1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c7864030.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c7864030.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c7864030.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c7864030.operation1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local at=Duel.GetAttacker()
		if at:IsAttackable() and not at:IsImmuneToEffect(e) and not tc:IsImmuneToEffect(e) then
			Duel.CalculateDamage(at,tc)
		end
	end
end
function c7864030.condition2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and Duel.GetAttackTarget()~=e:GetHandler()
end
function c7864030.operation2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		local at=Duel.GetAttacker()
		if at:IsAttackable() and not at:IsImmuneToEffect(e) then
			Duel.CalculateDamage(at,c)
		end
	end
end
