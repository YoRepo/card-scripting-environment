--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 战华之仲-孙谋  (ID: 40140448)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Beast-Warrior
-- Level 4
-- ATK 1800 | DEF 1500
-- Setcode: 311
--
-- Effect Text:
-- 这个卡名的②③的效果1回合各能使用1次。
-- ①：只要自己场上有其他的「战华」怪兽存在，对方不能选择这张卡作为攻击对象。
-- ②：从自己的手卡·场上把1张卡送去墓地才能发动。从卡组把「战华之仲-孙谋」以外的1只「战华」怪兽加入手卡。
-- ③：这张卡以外的自己的「战华」怪兽的效果发动的场合，以对方场上1只怪兽为对象才能发动。那只怪兽回到持有者手卡。
--[[ __CARD_HEADER_END__ ]]

--戦華の仲－孫謀
function c40140448.initial_effect(c)
	--can not be attack target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e1:SetCondition(c40140448.atcon)
	e1:SetValue(aux.imval1)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(40140448,0))
	e2:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,40140448)
	e2:SetCost(c40140448.srcost)
	e2:SetTarget(c40140448.srtg)
	e2:SetOperation(c40140448.srop)
	c:RegisterEffect(e2)
	--to hand
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(40140448,1))
	e4:SetCategory(CATEGORY_TOHAND)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_CHAINING)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1,40140449)
	e4:SetCondition(c40140448.thcon)
	e4:SetTarget(c40140448.thtg)
	e4:SetOperation(c40140448.thop)
	c:RegisterEffect(e4)
end
function c40140448.atfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x137)
end
function c40140448.atcon(e)
	return Duel.IsExistingMatchingCard(c40140448.atfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,e:GetHandler())
end
function c40140448.srcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToGraveAsCost,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,nil) end
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToGraveAsCost,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c40140448.srfilter(c)
	return c:IsSetCard(0x137) and c:IsAbleToHand() and not c:IsCode(40140448) and c:IsType(TYPE_MONSTER)
end
function c40140448.srtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c40140448.srfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c40140448.srop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c40140448.srfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c40140448.thcon(e,tp,eg,ep,ev,re,r,rp)
	return re:IsActiveType(TYPE_MONSTER) and re:GetHandler():IsSetCard(0x137) and rp==tp and re:GetHandler()~=e:GetHandler()
end
function c40140448.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsAbleToHand() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToHand,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,Card.IsAbleToHand,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c40140448.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
