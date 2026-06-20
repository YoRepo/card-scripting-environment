--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 石蕊的死仪式  (ID: 8955148)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 「石蕊之死剑士」的降临必需。这个卡名的②的效果1回合只能使用1次。
-- ①：从自己的手卡·场上把等级合计直到8以上的怪兽解放，从手卡把「石蕊之死剑士」仪式召唤。
-- ②：这张卡在墓地存在的场合，以自己墓地1只「石蕊之死剑士」为对象才能发动。墓地的这张卡和作为对象的怪兽合计2张加入卡组洗切。那之后，自己从卡组抽1张。
--[[ __CARD_HEADER_END__ ]]

--リトマスの死儀式
function c8955148.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,72566043)
	--to deck
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,8955148)
	e1:SetTarget(c8955148.tdtg)
	e1:SetOperation(c8955148.tdop)
	c:RegisterEffect(e1)
end
function c8955148.tdfilter(c)
	return c:IsCode(72566043) and c:IsAbleToDeck()
end
function c8955148.tdtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c8955148.tdfilter(chkc) and chkc~=e:GetHandler() end
	if chk==0 then return e:GetHandler():IsAbleToDeck()
		and Duel.IsExistingTarget(c8955148.tdfilter,tp,LOCATION_GRAVE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c8955148.tdfilter,tp,LOCATION_GRAVE,0,1,1,e:GetHandler())
	g:AddCard(e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c8955148.tdop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) then
		local g=Group.FromCards(c,tc)
		if Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)==0 then return end
		Duel.ShuffleDeck(tp)
		Duel.BreakEffect()
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
