--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 魔弹射手 卡斯帕  (ID: 32841045)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fiend
-- Level 3
-- ATK 1200 | DEF 2000
-- Setcode: 264
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：只要这张卡在怪兽区域存在，自己·对方回合自己可以把「魔弹」魔法·陷阱卡从手卡发动。
-- ②：和这张卡相同纵列有魔法·陷阱卡发动的场合才能发动。和那张发动的卡卡名不同的1张「魔弹」卡从卡组加入手卡。
--[[ __CARD_HEADER_END__ ]]

--魔弾の射手 カスパール
function c32841045.initial_effect(c)
	--activate from hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(32841045,1))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_QP_ACT_IN_NTPHAND)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x108))
	e1:SetTargetRange(LOCATION_HAND,0)
	e1:SetValue(32841045)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	c:RegisterEffect(e2)
	--search
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(32841045,0))
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_CHAINING)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,32841045)
	e3:SetCondition(c32841045.thcon)
	e3:SetTarget(c32841045.thtg)
	e3:SetOperation(c32841045.thop)
	c:RegisterEffect(e3)
end
function c32841045.thcon(e,tp,eg,ep,ev,re,r,rp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and e:GetHandler():GetColumnGroup():IsContains(re:GetHandler())
end
function c32841045.thfilter(c,rc)
	return c:IsSetCard(0x108) and not c:IsCode(rc:GetCode()) and c:IsAbleToHand()
end
function c32841045.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local rc=re:GetHandler()
	if chk==0 then return rc and Duel.IsExistingMatchingCard(c32841045.thfilter,tp,LOCATION_DECK,0,1,nil,rc) end
	e:SetLabelObject(rc)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c32841045.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c32841045.thfilter,tp,LOCATION_DECK,0,1,1,nil,e:GetLabelObject())
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
