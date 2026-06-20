--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 军队食人鱼  (ID: 50823978)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Fish
-- Level 2
-- ATK 800 | DEF 200
--
-- Effect Text:
-- 这张卡对对方进行直接攻击时战斗伤害加倍。
--[[ __CARD_HEADER_END__ ]]

--軍隊ピラニア
function c50823978.initial_effect(c)
	--deepen damage
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_BATTLE_DAMAGE)
	e1:SetCondition(c50823978.dcon)
	e1:SetValue(aux.ChangeBattleDamage(1,DOUBLE_DAMAGE))
	c:RegisterEffect(e1)
end
function c50823978.dcon(e)
	return Duel.GetAttackTarget()==nil
end
