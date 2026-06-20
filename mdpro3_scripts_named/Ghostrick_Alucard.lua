--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 鬼计妖魔·阿鲁卡德  (ID: 75367227)
-- Type: Monster / Effect / Xyz
-- Attribute: DARK
-- Race: Zombie
-- Rank 3
-- ATK 1800 | DEF 1600
-- Setcode: 141
--
-- Effect Text:
-- 3星怪兽×2
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：只要这张卡在怪兽区域存在，对方不能选择其他的「鬼计」怪兽以及里侧守备表示怪兽作为攻击对象。
-- ②：把这张卡1个超量素材取除，以对方场上盖放的1张卡为对象才能发动。那张盖放的对方的卡破坏。
-- ③：这张卡被送去墓地的场合，以这张卡以外的自己墓地1张「鬼计」卡为对象才能发动。那张卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--ゴーストリック・アルカード
function c75367227.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,3,2)
	c:EnableReviveLimit()
	--cannot be battle target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetValue(c75367227.tg)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetDescription(aux.Stringid(75367227,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,75367227)
	e2:SetCost(c75367227.descost)
	e2:SetTarget(c75367227.destg)
	e2:SetOperation(c75367227.desop)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetDescription(aux.Stringid(75367227,1))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetTarget(c75367227.thtg)
	e3:SetOperation(c75367227.thop)
	c:RegisterEffect(e3)
end
function c75367227.tg(e,c)
	return c~=e:GetHandler() and (c:IsFacedown() or c:IsSetCard(0x8d))
end
function c75367227.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c75367227.desfilter(c)
	return c:IsFacedown()
end
function c75367227.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and c75367227.desfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c75367227.desfilter,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c75367227.desfilter,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c75367227.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFacedown() then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c75367227.filter(c)
	return c:IsSetCard(0x8d) and c:IsAbleToHand()
end
function c75367227.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c75367227.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c75367227.filter,tp,LOCATION_GRAVE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c75367227.filter,tp,LOCATION_GRAVE,0,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c75367227.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end
