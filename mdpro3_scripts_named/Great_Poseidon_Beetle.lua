--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 海神独角仙  (ID: 75292259)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Insect
-- Level 7
-- ATK 2500 | DEF 2300
--
-- Effect Text:
-- 这张卡向对方场上表侧攻击表示存在的怪兽攻击，那只怪兽没被战斗破坏的场合，可以向同只怪兽继续攻击。这个效果1回合可以使用最多2次。
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
