--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Destiny HERO - Blade Master  (ID: 55461064)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Warrior
-- Level: 3
-- ATK 300 | DEF 600
-- Setcode: 0xc008
-- Scope: OCG / TCG
--
-- Effect Text:
-- During your opponent's Battle Phase (Quick Effect): You can discard this card; all "Destiny HERO"
-- monsters you currently control gain 800 ATK until the end of this turn.
--[[ __CARD_HEADER_END__ ]]

--D-HERO ダガーガイ
function c55461064.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(55461064,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_DAMAGE_STEP)
	e1:SetRange(LOCATION_HAND)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCondition(c55461064.atkcon)
	e1:SetCost(c55461064.atkcost)
	e1:SetTarget(c55461064.atktg)
	e1:SetOperation(c55461064.atkop)
	c:RegisterEffect(e1)
end
function c55461064.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return Duel.GetTurnPlayer()~=tp and ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE and aux.dscon(e,tp,eg,ep,ev,re,r,rp)
end
function c55461064.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c55461064.filter(c)
	return c:IsFaceup() and c:IsSetCard(0xc008)
end
function c55461064.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c55461064.filter,tp,LOCATION_MZONE,0,1,nil) end
end
function c55461064.atkop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c55461064.filter,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetOwnerPlayer(tp)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(800)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
