--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Mirror Gate  (ID: 43452193)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- When an opponent's monster declares an attack targeting a face-up "Elemental HERO" monster you
-- control: Switch control of the opponent's attacking monster with the targeted monster you control,
-- then calculate damage.
-- Control of both monsters switches back during the End Phase.
--[[ __CARD_HEADER_END__ ]]

--異次元トンネル－ミラーゲート－
function c43452193.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c43452193.condition)
	e1:SetTarget(c43452193.target)
	e1:SetOperation(c43452193.activate)
	c:RegisterEffect(e1)
end
function c43452193.condition(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttackTarget()
	return Duel.GetTurnPlayer()~=tp and at and at:IsFaceup() and at:IsSetCard(0x3008)
end
function c43452193.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local a=Duel.GetAttacker()
	local at=Duel.GetAttackTarget()
	if chk==0 then return a:IsOnField() and a:IsAbleToChangeControler() and Duel.GetMZoneCount(1-tp,a,1-tp,LOCATION_REASON_CONTROL)>0
		and at:IsOnField() and at:IsAbleToChangeControler() and Duel.GetMZoneCount(tp,at,tp,LOCATION_REASON_CONTROL)>0 end
	local g=Group.FromCards(a,at)
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,2,0,0)
end
function c43452193.activate(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local at=Duel.GetAttackTarget()
	if a:IsRelateToEffect(e) and a:IsAttackable() and at:IsRelateToEffect(e) then
		if Duel.SwapControl(a,at,RESET_PHASE+PHASE_END,1) then
			Duel.CalculateDamage(a,at)
		end
	end
end
