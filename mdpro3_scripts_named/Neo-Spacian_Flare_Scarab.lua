--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 新空间侠·火焰甲虫  (ID: 89621922)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Insect
-- Level 3
-- ATK 500 | DEF 500
-- Setcode: 31
--
-- Effect Text:
-- 这张卡的攻击力上升对方场上的魔法·陷阱卡数量×400的数值。
--[[ __CARD_HEADER_END__ ]]

--N・フレア・スカラベ
function c89621922.initial_effect(c)
	--atk up
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(89621922,0))
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c89621922.val)
	c:RegisterEffect(e1)
end
function c89621922.val(e,c)
	return Duel.GetMatchingGroupCount(Card.IsType,c:GetControler(),0,LOCATION_ONFIELD,nil,TYPE_SPELL+TYPE_TRAP)*400
end
