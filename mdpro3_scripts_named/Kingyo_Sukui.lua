--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 救金鱼  (ID: 9251497)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：以对方墓地1只怪兽为对象才能发动。自己卡组最上面的卡翻开。翻开的卡是持有和作为对象的怪兽相同属性的怪兽的场合，翻开的卡加入手卡，作为对象的怪兽回到对方卡组。不是的场合，翻开的卡送去墓地，这张卡破坏
-- 。
--[[ __CARD_HEADER_END__ ]]

--金魚救い
function c9251497.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--to hand & todeck or to GY & selfdestroy
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_TODECK+CATEGORY_SEARCH+CATEGORY_DECKDES+CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCountLimit(1,9251497)
	e2:SetTarget(c9251497.target)
	e2:SetOperation(c9251497.operation)
	c:RegisterEffect(e2)
end
function c9251497.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(1-tp) and chkc:IsType(TYPE_MONSTER) end
	if chk==0 then return Duel.IsExistingTarget(Card.IsType,tp,0,LOCATION_GRAVE,1,nil,TYPE_MONSTER)
		and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,Card.IsType,tp,0,LOCATION_GRAVE,1,1,nil,TYPE_MONSTER)
end
function c9251497.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)<=0 then return end
	Duel.ConfirmDecktop(tp,1)
	local tc=Duel.GetFirstTarget()
	local g=Duel.GetDecktopGroup(tp,1)
	if tc:IsRelateToEffect(e) then
		if g:GetFirst():GetAttribute()&tc:GetAttribute()~=0 then
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.SendtoDeck(tc,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
		else
			Duel.SendtoGrave(g,REASON_EFFECT+REASON_REVEAL)
			Duel.Destroy(e:GetHandler(),REASON_EFFECT)
		end
	end
end
