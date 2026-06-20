--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 闪刀姬-燎里  (ID: 63288573)
-- Type: Monster / Effect / Link
-- Attribute: FIRE
-- Race: Machine
-- ATK 1500 | LINK
-- Setcode: 4373
--
-- Effect Text:
-- 炎属性以外的「闪刀姬」怪兽1只
-- 自己对「闪刀姬-燎里」1回合只能有1次特殊召唤。
-- ①：这张卡特殊召唤的场合，以自己墓地1张「闪刀」魔法卡为对象才能发动。那张卡加入手卡。
-- ②：这张卡的攻击力上升自己墓地的魔法卡数量×100。
--[[ __CARD_HEADER_END__ ]]

--閃刀姫－カガリ
function c63288573.initial_effect(c)
	c:SetSPSummonOnce(63288573)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,c63288573.matfilter,1,1)
	--atk up
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetValue(c63288573.atkval)
	c:RegisterEffect(e1)
	--search
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(63288573,0))
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e3:SetTarget(c63288573.thtg)
	e3:SetOperation(c63288573.thop)
	c:RegisterEffect(e3)
end
function c63288573.matfilter(c)
	return c:IsLinkSetCard(0x1115) and c:IsLinkAttribute(ATTRIBUTE_ALL&~ATTRIBUTE_FIRE)
end
function c63288573.atkval(e)
	return Duel.GetMatchingGroupCount(Card.IsType,e:GetHandlerPlayer(),LOCATION_GRAVE,0,nil,TYPE_SPELL)*100
end
function c63288573.thfilter(c,tp)
	return c:IsSetCard(0x115) and c:IsType(TYPE_SPELL) and c:IsAbleToHand()
end
function c63288573.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c63288573.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c63288573.thfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local sg=Duel.SelectTarget(tp,c63288573.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,sg,1,0,0)
end
function c63288573.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
