--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 妖精守护者  (ID: 22419772)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Fairy
-- Level 3
-- ATK 1000 | DEF 1000
-- Setcode: 82
--
-- Effect Text:
-- 表侧表示的这张卡做祭品。这个回合因为对方造成的送去墓地的自己的1张魔法卡回到卡组最下面。
--[[ __CARD_HEADER_END__ ]]

--ピクシーガーディアン
function c22419772.initial_effect(c)
	--to deck
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(22419772,0))
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c22419772.cost)
	e1:SetTarget(c22419772.target)
	e1:SetOperation(c22419772.operation)
	c:RegisterEffect(e1)
end
function c22419772.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c22419772.filter(c,tp,tid)
	return c:IsAbleToDeck() and c:IsType(TYPE_SPELL) and c:GetTurnID()==tid and c:GetReasonPlayer()==1-tp
end
function c22419772.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tid=Duel.GetTurnCount()
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c22419772.filter(chkc,tp,tid) end
	if chk==0 then return Duel.IsExistingTarget(c22419772.filter,tp,LOCATION_GRAVE,0,1,nil,tp,tid) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c22419772.filter,tp,LOCATION_GRAVE,0,1,1,nil,tp,tid)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end
function c22419772.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoDeck(tc,nil,SEQ_DECKBOTTOM,REASON_EFFECT)
	end
end
