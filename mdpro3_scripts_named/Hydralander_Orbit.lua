--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 着陆九头蛇·轨道分机  (ID: 93953933)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level 1
-- ATK 0 | DEF 1500
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：自己墓地有怪兽4只以上存在，那些卡名全部不同的场合，把这张卡解放才能发动。把自己墓地的怪兽数量的卡从自己卡组上面翻开。怪兽2只以上被翻开，那些卡名全部不同的场合，那之内的1只加入手卡。剩下的卡用喜
-- 欢的顺序回到卡组上面。
-- ②：把墓地的这张卡除外，以自己墓地1只怪兽为对象才能发动。那只怪兽回到卡组最下面。
--[[ __CARD_HEADER_END__ ]]

--ハイドランダー・オービット
function c93953933.initial_effect(c)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,93953933)
	e1:SetCondition(c93953933.thcon)
	e1:SetCost(c93953933.thcost)
	e1:SetTarget(c93953933.thtg)
	e1:SetOperation(c93953933.thop)
	c:RegisterEffect(e1)
	--to deck
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,93953934)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c93953933.tdtg)
	e2:SetOperation(c93953933.tdop)
	c:RegisterEffect(e2)
end
function c93953933.thcon(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_GRAVE,0,nil,TYPE_MONSTER)
	return g:GetCount()>=4 and g:GetClassCount(Card.GetCode)==g:GetCount()
end
function c93953933.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c93953933.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local ct=Duel.GetMatchingGroupCount(Card.IsType,tp,LOCATION_GRAVE,0,nil,TYPE_MONSTER)
		if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)<ct then return false end
		local g=Duel.GetDecktopGroup(tp,ct)
		return g:FilterCount(Card.IsAbleToHand,nil)>0
	end
end
function c93953933.thop(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(Card.IsType,tp,LOCATION_GRAVE,0,nil,TYPE_MONSTER)
	Duel.ConfirmDecktop(tp,ct)
	local dg=Duel.GetDecktopGroup(tp,ct)
	local g=dg:Filter(Card.IsType,nil,TYPE_MONSTER)
	if g:GetCount()>=2 and g:GetClassCount(Card.GetCode)==g:GetCount() then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,1,1,nil)
		Duel.DisableShuffleCheck()
		if sg:GetFirst():IsAbleToHand() then
			Duel.SendtoHand(sg,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,sg)
			Duel.ShuffleHand(tp)
		else
			Duel.SendtoGrave(sg,REASON_RULE)
		end
		Duel.SortDecktop(tp,tp,dg:GetCount()-1)
	else Duel.SortDecktop(tp,tp,dg:GetCount()) end
end
function c93953933.tdfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToDeck()
end
function c93953933.tdtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c93953933.tdfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c93953933.tdfilter,tp,LOCATION_GRAVE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c93953933.tdfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end
function c93953933.tdop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoDeck(tc,nil,SEQ_DECKBOTTOM,REASON_EFFECT)
	end
end
