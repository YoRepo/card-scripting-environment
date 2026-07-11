--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Counter Gate  (ID: 94561645)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- When an opponent's monster declares a direct attack: Negate the attack, and if you do, draw 1 card,
-- then if it is a monster, immediately after this effect resolves, you can Normal Summon it in face-up
-- Attack Position.
--[[ __CARD_HEADER_END__ ]]

--カウンター・ゲート
function c94561645.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW+CATEGORY_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c94561645.condition)
	e1:SetTarget(c94561645.target)
	e1:SetOperation(c94561645.activate)
	c:RegisterEffect(e1)
end
function c94561645.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp) and Duel.GetAttackTarget()==nil
end
function c94561645.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c94561645.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateAttack() and Duel.Draw(tp,1,REASON_EFFECT)~=0 then
		local tc=Duel.GetOperatedGroup():GetFirst()
		if tc:IsType(TYPE_MONSTER) and tc:IsSummonable(true,nil)
			and Duel.SelectYesNo(tp,aux.Stringid(94561645,0)) then
			Duel.BreakEffect()
			Duel.Summon(tp,tc,true,nil)
		end
	end
end
