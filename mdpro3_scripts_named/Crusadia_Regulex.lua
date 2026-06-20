--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 狮子王之圣像骑士  (ID: 9617996)
-- Type: Monster / Effect / Link
-- Attribute: LIGHT
-- Race: Beast
-- ATK 1000 | LINK
-- Setcode: 278
--
-- Effect Text:
-- 包含「圣像骑士」怪兽的效果怪兽2只
-- 这个卡名的③的效果1回合只能使用1次。
-- ①：这张卡的攻击力上升这张卡所连接区的怪兽的原本攻击力数值。
-- ②：这张卡所连接区的怪兽不能攻击。
-- ③：这张卡所连接区有效果怪兽特殊召唤的场合才能发动。从卡组把1张「圣像骑士」魔法·陷阱卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--レグレクス・パラディオン
function c9617996.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkType,TYPE_EFFECT),2,2,c9617996.lcheck)
	c:EnableReviveLimit()
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c9617996.atkval)
	c:RegisterEffect(e1)
	--cannot attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c9617996.antg)
	c:RegisterEffect(e2)
	--to hand
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(9617996,0))
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCountLimit(1,9617996)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c9617996.thcon)
	e3:SetTarget(c9617996.thtg)
	e3:SetOperation(c9617996.thop)
	c:RegisterEffect(e3)
end
function c9617996.lcheck(g,lc)
	return g:IsExists(Card.IsLinkSetCard,1,nil,0x116)
end
function c9617996.atkval(e,c)
	local g=e:GetHandler():GetLinkedGroup():Filter(Card.IsFaceup,nil)
	return g:GetSum(Card.GetBaseAttack)
end
function c9617996.antg(e,c)
	return e:GetHandler():GetLinkedGroup():IsContains(c)
end
function c9617996.cfilter(c,lg)
	return c:IsType(TYPE_EFFECT) and lg:IsContains(c)
end
function c9617996.thcon(e,tp,eg,ep,ev,re,r,rp)
	local lg=e:GetHandler():GetLinkedGroup()
	return eg:IsExists(c9617996.cfilter,1,nil,lg)
end
function c9617996.thfilter(c)
	return c:IsSetCard(0x116) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand()
end
function c9617996.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c9617996.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c9617996.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c9617996.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
