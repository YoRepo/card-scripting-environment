--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 朱罗纪原角龙  (ID: 23927545)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Dinosaur
-- Level 4
-- ATK 1700 | DEF 1200
-- Setcode: 34
--
-- Effect Text:
-- 这张卡的攻击力上升对方场上存在的怪兽数量×100的数值。
--[[ __CARD_HEADER_END__ ]]

--ジュラック・プロトプス
function c23927545.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c23927545.val)
	c:RegisterEffect(e1)
end
function c23927545.val(e,c)
	return Duel.GetFieldGroupCount(c:GetControler(),0,LOCATION_MZONE)*100
end
