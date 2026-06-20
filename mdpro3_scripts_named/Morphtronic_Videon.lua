--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 变形斗士·摄像机  (ID: 84592800)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Machine
-- Level 4
-- ATK 1000 | DEF 1000
-- Setcode: 38
--
-- Effect Text:
-- 这张卡得到这张卡的表示形式的以下效果。
-- ●攻击表示：这张卡的攻击力上升这张卡装备的装备卡数量×800的数值。
-- ●守备表示：这张卡的守备力上升这张卡装备的装备卡数量×800的数值。
--[[ __CARD_HEADER_END__ ]]

--D・ビデオン
function c84592800.initial_effect(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetCondition(c84592800.cona)
	e1:SetValue(c84592800.val)
	c:RegisterEffect(e1)
	--def
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	e2:SetCondition(c84592800.cond)
	c:RegisterEffect(e2)
end
function c84592800.cona(e)
	return e:GetHandler():IsAttackPos()
end
function c84592800.cond(e)
	return e:GetHandler():IsDefensePos()
end
function c84592800.val(e,c)
	return c:GetEquipCount()*800
end
