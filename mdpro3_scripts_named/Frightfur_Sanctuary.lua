--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 魔玩具圣域  (ID: 74839123)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
-- Setcode: 173
--
-- Effect Text:
-- 丢弃1张手卡，从自己的额外卡组把2只「魔玩具」怪兽送去墓地才能把这张卡发动。
-- ①：只要这张卡在魔法与陷阱区域存在，自己场上的全部融合怪兽也当作「魔玩具」怪兽使用。
-- ②：这张卡被送去墓地的场合，以自己墓地1只「魔玩具」融合怪兽为对象才能发动。那只怪兽回到额外卡组。
--[[ __CARD_HEADER_END__ ]]

--デストーイ・サンクチュアリ
function c74839123.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c74839123.cost)
	c:RegisterEffect(e1)
	--add setcode
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsType,TYPE_FUSION))
	e2:SetCode(EFFECT_ADD_SETCODE)
	e2:SetValue(0xad)
	c:RegisterEffect(e2)
	--return
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOEXTRA)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e3:SetTarget(c74839123.tdtg)
	e3:SetOperation(c74839123.tdop)
	c:RegisterEffect(e3)
end
function c74839123.cfilter(c)
	return c:IsSetCard(0xad) and c:IsType(TYPE_MONSTER) and c:IsAbleToGraveAsCost()
end
function c74839123.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,e:GetHandler())
		and Duel.IsExistingMatchingCard(c74839123.cfilter,tp,LOCATION_EXTRA,0,2,nil) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c74839123.cfilter,tp,LOCATION_EXTRA,0,2,2,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c74839123.filter(c)
	return c:IsSetCard(0xad) and c:IsType(TYPE_FUSION) and c:IsAbleToExtra()
end
function c74839123.tdtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c74839123.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c74839123.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c74839123.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOEXTRA,g,1,0,0)
end
function c74839123.tdop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoDeck(tc,nil,SEQ_DECKTOP,REASON_EFFECT)
	end
end
