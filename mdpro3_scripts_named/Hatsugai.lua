--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 初买  (ID: 43618262)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：从对方卡组上面把5张卡翻开，自己从那之中选1张并宣言100的倍数的数值（最多3000）。对方可以回复那个数值的基本分。回复的场合，自己失去那个数值的基本分，选的卡加入自己手卡，剩下的卡用原本的顺序
-- 回到卡组上面。没回复的场合，翻开的卡用原本的顺序回到卡组上面。
--[[ __CARD_HEADER_END__ ]]

--初買い
function c43618262.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_RECOVER+CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c43618262.cftg)
	e1:SetOperation(c43618262.cfop)
	c:RegisterEffect(e1)
end
function c43618262.cftg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetDecktopGroup(1-tp,5)
	if chk==0 then return g:FilterCount(Card.IsAbleToHand,nil,tp)>0 end
	Duel.SetTargetPlayer(tp)
end
function c43618262.cfop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local g=Duel.GetDecktopGroup(1-p,5)
	if g:FilterCount(Card.IsAbleToHand,nil,tp)==0 then return end
	Duel.ConfirmDecktop(1-p,5)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	Duel.RevealSelectDeckSequence(true)
	local tc=g:FilterSelect(tp,Card.IsAbleToHand,1,1,nil,tp):GetFirst()
	Duel.RevealSelectDeckSequence(false)
	local num=math.floor(3000/100)
	local t={}
	for i=1,num do
		t[i]=i*100
	end
	local val=Duel.AnnounceNumber(tp,table.unpack(t))
	if Duel.SelectYesNo(1-p,aux.Stringid(43618262,0)) then
		if Duel.Recover(1-p,val,REASON_EFFECT)>0 then
			Duel.SetLP(tp,Duel.GetLP(tp)-val)
			Duel.DisableShuffleCheck(true)
			Duel.SendtoHand(tc,p,REASON_EFFECT)
			Duel.ConfirmCards(1-p,tc)
			Duel.ShuffleHand(p)
		end
	end
end
