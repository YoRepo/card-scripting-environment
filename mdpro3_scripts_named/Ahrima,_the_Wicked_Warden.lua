--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 恶王 阿里曼  (ID: 86377375)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 4
-- ATK 1700 | DEF 0
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：把这张卡从手卡丢弃才能发动。从卡组把1张「黯黑世界-暗影敌托邦-」加入手卡。
-- ②：把自己场上1只暗属性怪兽解放才能发动。自己从卡组抽1张。为这个效果发动而把这张卡以外的暗属性怪兽解放的场合，可以作为抽卡的代替而从卡组把1只守备力2000以上的暗属性怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--悪王アフリマ
function c86377375.initial_effect(c)
	aux.AddCodeList(c,59160188)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(86377375,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCost(c86377375.thcost)
	e1:SetTarget(c86377375.thtg)
	e1:SetOperation(c86377375.thop)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(86377375,1))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,86377375)
	e2:SetCost(c86377375.drcost)
	e2:SetTarget(c86377375.drtg)
	e2:SetOperation(c86377375.drop)
	c:RegisterEffect(e2)
end
function c86377375.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsDiscardable() end
	Duel.SendtoGrave(c,REASON_COST+REASON_DISCARD)
end
function c86377375.thfilter1(c)
	return c:IsCode(59160188) and c:IsAbleToHand()
end
function c86377375.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c86377375.thfilter1,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c86377375.thop(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetFirstMatchingCard(c86377375.thfilter1,tp,LOCATION_DECK,0,nil)
	if tg then
		Duel.SendtoHand(tg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tg)
	end
end
function c86377375.thfilter2(c)
	return c:IsAttribute(ATTRIBUTE_DARK) and c:IsDefenseAbove(2000) and c:IsAbleToHand()
end
function c86377375.drcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return ((Duel.CheckReleaseGroup(tp,Card.IsAttribute,1,nil,ATTRIBUTE_DARK) and Duel.IsPlayerCanDraw(tp,1))
		or (Duel.CheckReleaseGroup(tp,Card.IsAttribute,1,c,ATTRIBUTE_DARK) and Duel.IsExistingMatchingCard(c86377375.thfilter2,tp,LOCATION_DECK,0,1,nil))) end
	local sg=nil
	if Duel.IsExistingMatchingCard(c86377375.thfilter2,tp,LOCATION_DECK,0,1,nil) and not Duel.IsPlayerCanDraw(tp,1) then
		sg=Duel.SelectReleaseGroup(tp,Card.IsAttribute,1,1,c,ATTRIBUTE_DARK)
	else
		sg=Duel.SelectReleaseGroup(tp,Card.IsAttribute,1,1,nil,ATTRIBUTE_DARK)
	end
	e:SetLabelObject(sg:GetFirst())
	Duel.Release(sg,REASON_COST)
end
function c86377375.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	if e:GetLabelObject()~=e:GetHandler() then
		e:SetCategory(CATEGORY_DRAW+CATEGORY_TOHAND+CATEGORY_SEARCH)
	end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c86377375.drop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabelObject()~=e:GetHandler() and Duel.IsExistingMatchingCard(c86377375.thfilter2,tp,LOCATION_DECK,0,1,nil)
		and (not Duel.IsPlayerCanDraw(tp,1) or Duel.SelectYesNo(tp,aux.Stringid(86377375,2))) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,c86377375.thfilter2,tp,LOCATION_DECK,0,1,1,nil)
		if g:GetCount()>0 then
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		end
	else
		local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
		Duel.Draw(p,d,REASON_EFFECT)
	end
end
