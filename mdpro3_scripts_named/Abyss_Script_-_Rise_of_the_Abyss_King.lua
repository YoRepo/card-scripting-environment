--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 魔界台本「魔王的降临」  (ID: 13662809)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 8428
--
-- Effect Text:
-- ①：以最多有自己场上的攻击表示的「魔界剧团」怪兽种类数量的场上的表侧表示的卡为对象才能发动。那些卡破坏。自己场上有7星以上的「魔界剧团」怪兽存在的场合，对方不能对应这张卡的发动把效果发动。
-- ②：自己的额外卡组有表侧表示的「魔界剧团」灵摆怪兽存在，盖放的这张卡被对方的效果破坏的场合才能发动。从卡组把「魔界剧团」卡或者「魔界台本」魔法卡合计最多2张加入手卡（同名卡最多1张）。
--[[ __CARD_HEADER_END__ ]]

--魔界台本「魔王の降臨」
function c13662809.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(13662809,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c13662809.target)
	e1:SetOperation(c13662809.activate)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(13662809,1))
	e2:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetCondition(c13662809.thcon)
	e2:SetTarget(c13662809.thtg)
	e2:SetOperation(c13662809.thop)
	c:RegisterEffect(e2)
end
function c13662809.cfilter(c)
	return c:IsPosition(POS_FACEUP_ATTACK) and c:IsSetCard(0x10ec)
end
function c13662809.lmfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x10ec) and c:IsLevelAbove(7)
end
function c13662809.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsFaceup() and chkc~=e:GetHandler() end
	if chk==0 then return Duel.IsExistingMatchingCard(c13662809.cfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
	local g=Duel.GetMatchingGroup(c13662809.cfilter,tp,LOCATION_MZONE,0,nil)
	local ct=g:GetClassCount(Card.GetCode)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local sg=Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,ct,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
	if Duel.IsExistingMatchingCard(c13662809.lmfilter,tp,LOCATION_MZONE,0,1,nil) and e:IsHasType(EFFECT_TYPE_ACTIVATE) then
		Duel.SetChainLimit(c13662809.chainlm)
	end
end
function c13662809.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	Duel.Destroy(g,REASON_EFFECT)
end
function c13662809.chainlm(e,rp,tp)
	return tp==rp
end
function c13662809.filter2(c)
	return c:IsSetCard(0x10ec) and c:IsFaceup() and c:IsType(TYPE_PENDULUM)
end
function c13662809.thcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_EFFECT) and rp==1-tp and c:IsPreviousControler(tp)
		and c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsPreviousPosition(POS_FACEDOWN)
		and Duel.IsExistingMatchingCard(c13662809.filter2,tp,LOCATION_EXTRA,0,1,nil)
end
function c13662809.thfilter(c)
	return (c:IsSetCard(0x10ec) or (c:IsSetCard(0x20ec) and c:IsType(TYPE_SPELL))) and c:IsAbleToHand()
end
function c13662809.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c13662809.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c13662809.thop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c13662809.thfilter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local sg1=g:SelectSubGroup(tp,aux.dncheck,false,1,2)
	Duel.SendtoHand(sg1,nil,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,sg1)
end
