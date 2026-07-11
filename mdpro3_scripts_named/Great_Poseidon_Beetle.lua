--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Great Poseidon Beetle  (ID: 75292259)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Insect
-- Level: 7
-- ATK 2500 | DEF 2300
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card targets an opponent's face-up Attack Position monster for an attack, and that monster
-- is not destroyed by the battle, this card can attack the same monster again in a row.
-- This effect can only be used twice per turn.
--[[ __CARD_HEADER_END__ ]]

--ポセイドン・オオカブト
function c75292259.initial_effect(c)
	--chain attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_DAMAGE_STEP_END)
	e1:SetCondition(c75292259.atcon)
	e1:SetOperation(c75292259.atop)
	c:RegisterEffect(e1)
end
function c75292259.atcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return c==Duel.GetAttacker() and bc and bc:IsRelateToBattle()
		and bc:GetBattlePosition()==POS_FACEUP_ATTACK and c:IsChainAttackable(3)
end
function c75292259.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChainAttack(e:GetHandler():GetBattleTarget())
end
