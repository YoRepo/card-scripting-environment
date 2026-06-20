--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 魔镜导士 念界反弹者  (ID: 65471349)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Machine
-- Level 4
-- ATK 1700 | DEF 1000
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：这张卡召唤·特殊召唤成功的场合才能发动。把1只「人造人-念力震慑者」或者1张有那个卡名记述的魔法·陷阱卡从卡组加入手卡。
-- ②：这张卡以外的自己怪兽被对方怪兽攻击的伤害计算前才能发动。攻击怪兽和这张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--魔鏡導士サイコ・バウンダー
function c65471349.initial_effect(c)
	aux.AddCodeList(c,77585513)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(65471349,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,65471349)
	e1:SetTarget(c65471349.thtg)
	e1:SetOperation(c65471349.thop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(65471349,1))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLE_CONFIRM)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,65471350)
	e3:SetCondition(c65471349.descon)
	e3:SetTarget(c65471349.destg)
	e3:SetOperation(c65471349.desop)
	c:RegisterEffect(e3)
end
function c65471349.thfilter(c)
	return (c:IsCode(77585513) or aux.IsCodeListed(c,77585513) and c:IsType(TYPE_SPELL+TYPE_TRAP)) and c:IsAbleToHand()
end
function c65471349.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c65471349.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c65471349.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c65471349.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c65471349.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ac=Duel.GetAttacker()
	local bc=Duel.GetAttackTarget()
	return bc and bc:IsControler(tp) and bc~=c and ac:IsControler(1-tp)
end
function c65471349.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local dc=Duel.GetAttacker()
	local g=Group.FromCards(c,dc)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,2,0,0)
end
function c65471349.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local dc=Duel.GetAttacker()
	if c:IsRelateToEffect(e) and dc:IsRelateToBattle() then
		local g=Group.FromCards(c,dc)
		Duel.Destroy(g,REASON_EFFECT)
	end
end
