--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 真红眼的凶星龙-流星之龙  (ID: 17871506)
-- Type: Monster / Effect / Gemini
-- Attribute: DARK
-- Race: Dragon
-- Level 6
-- ATK 1800 | DEF 2000
-- Setcode: 59
--
-- Effect Text:
-- ①：这张卡只要在场上·墓地存在，当作通常怪兽使用。
-- ②：可以把场上的当作通常怪兽使用的这张卡作为通常召唤作再1次召唤。那个场合这张卡变成当作效果怪兽使用并得到以下效果。
-- ●只要这张卡在怪兽区域存在，这张卡以外的自己场上的「真红眼」怪兽不会被战斗·效果破坏。
--[[ __CARD_HEADER_END__ ]]

--真紅眼の凶星竜－メテオ・ドラゴン
function c17871506.initial_effect(c)
	aux.EnableDualAttribute(c)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c17871506.indtg)
	e1:SetValue(1)
	e1:SetCondition(aux.IsDualState)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	c:RegisterEffect(e2)
end
function c17871506.indtg(e,c)
	return c:IsSetCard(0x3b) and c~=e:GetHandler()
end
