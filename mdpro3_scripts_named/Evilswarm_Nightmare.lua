--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 入魔梦魇骑士  (ID: 359563)
-- Type: Monster / Effect / Xyz
-- Attribute: DARK
-- Race: Fiend
-- Rank 4
-- ATK 950 | DEF 1950
-- Setcode: 10
--
-- Effect Text:
-- 暗属性4星怪兽×2
-- ①：对方把怪兽特殊召唤时，把这张卡1个超量素材取除才能发动。那些怪兽变成里侧守备表示。
--[[ __CARD_HEADER_END__ ]]

--ヴェルズ・ナイトメア
function c359563.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_DARK),4,2)
	c:EnableReviveLimit()
	--pos
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(359563,0))
	e1:SetCategory(CATEGORY_POSITION+CATEGORY_MSET)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c359563.cost)
	e1:SetTarget(c359563.target)
	e1:SetOperation(c359563.operation)
	c:RegisterEffect(e1)
end
function c359563.filter(c,e,tp)
	return c:IsFaceup() and c:IsCanTurnSet() and c:IsSummonPlayer(1-tp) and (not e or c:IsRelateToEffect(e))
end
function c359563.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c359563.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c359563.filter,1,nil,nil,tp) end
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,eg,eg:GetCount(),0,0)
end
function c359563.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c359563.filter,nil,e,tp)
	Duel.ChangePosition(g,POS_FACEDOWN_DEFENSE)
end
