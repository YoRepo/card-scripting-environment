--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 闪刀姬-雫空  (ID: 90673288)
-- Type: Monster / Effect / Link
-- Attribute: WATER
-- Race: Machine
-- ATK 1500 | LINK
-- Setcode: 4373
--
-- Effect Text:
-- 水属性以外的「闪刀姬」怪兽1只
-- 自己对「闪刀姬-雫空」1回合只能有1次特殊召唤。
-- ①：对方场上的怪兽的攻击力·守备力下降自己墓地的魔法卡数量×100。
-- ②：这张卡特殊召唤的回合的结束阶段才能发动。同名卡不在自己墓地存在的1张「闪刀」魔法卡从卡组加入手卡。
--[[ __CARD_HEADER_END__ ]]

--閃刀姫－シズク
function c90673288.initial_effect(c)
	c:SetSPSummonOnce(90673288)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,c90673288.matfilter,1,1)
	--atk down
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetValue(c90673288.atkval)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e2)
	--search
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetOperation(c90673288.regop)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(90673288,0))
	e4:SetCategory(CATEGORY_SEARCH)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_PHASE+PHASE_END)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetCondition(c90673288.thcon)
	e4:SetTarget(c90673288.thtg)
	e4:SetOperation(c90673288.thop)
	c:RegisterEffect(e4)
end
function c90673288.matfilter(c)
	return c:IsLinkSetCard(0x1115) and c:IsLinkAttribute(ATTRIBUTE_ALL&~ATTRIBUTE_WATER)
end
function c90673288.atkval(e)
	return Duel.GetMatchingGroupCount(Card.IsType,e:GetHandlerPlayer(),LOCATION_GRAVE,0,nil,TYPE_SPELL)*-100
end
function c90673288.regop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(90673288,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1)
end
function c90673288.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(90673288)~=0
end
function c90673288.thfilter(c,tp)
	return c:IsSetCard(0x115) and c:IsType(TYPE_SPELL) and c:IsAbleToHand()
		and not Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,c:GetCode())
end
function c90673288.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c90673288.thfilter,tp,LOCATION_DECK,0,1,nil,tp) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c90673288.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c90673288.thfilter,tp,LOCATION_DECK,0,1,1,nil,tp)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
