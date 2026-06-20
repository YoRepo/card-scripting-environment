--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 零零封锁  (ID: 85446833)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 只要这张卡在场上存在，对方不能选择表侧攻击表示存在的攻击力0的怪兽作为攻击对象。
--[[ __CARD_HEADER_END__ ]]

--ゼロゼロック
function c85446833.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atklimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetValue(c85446833.target)
	c:RegisterEffect(e2)
end
function c85446833.target(e,c)
	return c:IsPosition(POS_FACEUP_ATTACK) and c:IsAttack(0)
end
