--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 森之圣兽 羊驼驯鹿  (ID: 77797992)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast
-- Level 7
-- ATK 2700 | DEF 2100
-- Setcode: 4455
--
-- Effect Text:
-- 这张卡得到这张卡的表示形式的以下效果。
-- ●攻击表示：自己场上表侧攻击表示存在的鸟兽族·昆虫族·植物族怪兽不会被战斗破坏。
-- ●守备表示：自己场上表侧守备表示存在的鸟兽族·昆虫族·植物族怪兽不会成为卡的效果的对象，不会被卡的效果破坏。
--[[ __CARD_HEADER_END__ ]]

--森の聖獣 アルパカリブ
function c77797992.initial_effect(c)
	--indes1
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetCondition(c77797992.cona)
	e1:SetTarget(c77797992.targeta)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--cannot be target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCondition(c77797992.cond)
	e2:SetTarget(c77797992.targetd)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e3:SetValue(1)
	c:RegisterEffect(e3)
end
function c77797992.cona(e)
	return e:GetHandler():IsAttackPos()
end
function c77797992.targeta(e,c)
	return c:IsPosition(POS_FACEUP_ATTACK) and c:IsRace(RACE_WINDBEAST+RACE_PLANT+RACE_INSECT)
end
function c77797992.cond(e)
	return e:GetHandler():IsDefensePos()
end
function c77797992.targetd(e,c)
	return c:IsPosition(POS_FACEUP_DEFENSE) and c:IsRace(RACE_WINDBEAST+RACE_PLANT+RACE_INSECT)
end
