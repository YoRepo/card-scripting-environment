--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 蛇发之咒眼  (ID: 28957126)
-- Type: Spell / Field
-- ATK 0 | DEF 0
-- Setcode: 297
--
-- Effect Text:
-- 「咒眼」怪兽才能装备。这个卡名的卡在1回合只能发动1张，这个卡名的③的效果1回合只能使用1次。
-- ①：这张卡只要在魔法与陷阱区域存在，卡名当作「太阴之咒眼」使用。
-- ②：自己基本分比对方少的场合，装备怪兽的攻击力上升基本分差的数值。
-- ③：把墓地的这张卡除外，从手卡丢弃1张「咒眼」卡才能发动。从卡组把「蛇发之咒眼」以外的1张「咒眼」魔法·陷阱卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--ゴルゴネイオの呪眼
function c28957126.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CONTINUOUS_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,28957126+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c28957126.target)
	e1:SetOperation(c28957126.operation)
	c:RegisterEffect(e1)
	--change code
	aux.EnableChangeCode(c,44133040)
	--atkup
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetCondition(c28957126.atkcon)
	e3:SetValue(c28957126.atkval)
	c:RegisterEffect(e3)
	--Equip limit
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetCode(EFFECT_EQUIP_LIMIT)
	e4:SetValue(c28957126.eqlimit)
	c:RegisterEffect(e4)
	--to hand
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(28957126,0))
	e5:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_GRAVE)
	e5:SetCountLimit(1,28957126)
	e5:SetCost(c28957126.thcost)
	e5:SetTarget(c28957126.thtg)
	e5:SetOperation(c28957126.thop)
	c:RegisterEffect(e5)
end
function c28957126.eqlimit(e,c)
	return c:IsSetCard(0x129)
end
function c28957126.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x129)
end
function c28957126.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c28957126.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c28957126.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c28957126.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c28957126.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,e:GetHandler(),tc)
	end
end
function c28957126.atkcon(e)
	local tp=e:GetHandlerPlayer()
	return Duel.GetLP(tp)<Duel.GetLP(1-tp)
end
function c28957126.atkval(e,c)
	return math.abs(Duel.GetLP(0)-Duel.GetLP(1))
end
function c28957126.costfilter(c)
	return c:IsSetCard(0x129) and c:IsDiscardable()
end
function c28957126.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return aux.bfgcost(e,tp,eg,ep,ev,re,r,rp,0)
		and Duel.IsExistingMatchingCard(c28957126.costfilter,tp,LOCATION_HAND,0,1,nil) end
	aux.bfgcost(e,tp,eg,ep,ev,re,r,rp,1)
	Duel.DiscardHand(tp,c28957126.costfilter,1,1,REASON_COST+REASON_DISCARD,nil)
end
function c28957126.thfilter(c)
	return c:IsSetCard(0x129) and c:IsType(TYPE_SPELL+TYPE_TRAP) and not c:IsCode(28957126) and c:IsAbleToHand()
end
function c28957126.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c28957126.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c28957126.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c28957126.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
