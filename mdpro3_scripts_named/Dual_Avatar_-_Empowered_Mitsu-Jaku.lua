--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 双天将 密迹  (ID: 284224)
-- Type: Monster / Effect / Fusion
-- Attribute: LIGHT
-- Race: Warrior
-- Level 7
-- ATK 2000 | DEF 3000
-- Setcode: 335
--
-- Effect Text:
-- 「双天脚之鸿鹄」＋「双天」怪兽×2
-- 这个卡名的③的效果1回合只能使用1次。
-- ①：只要这张卡在怪兽区域存在，自己的「双天」融合怪兽在1回合各有1次不会被战斗破坏。
-- ②：1回合1次，自己主要阶段才能发动。对方场上的魔法·陷阱卡全部回到持有者手卡。
-- ③：自己场上有融合怪兽2只以上存在，对方场上的怪兽的效果发动时才能发动。那只怪兽破坏。
--[[ __CARD_HEADER_END__ ]]

--双天将 密迹
function c284224.initial_effect(c)
	--fusion
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,11759079,aux.FilterBoolFunction(Card.IsFusionSetCard,0x14f),2,true,true)
	--effect monster material check
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetCode(EFFECT_MATERIAL_CHECK)
	e0:SetValue(c284224.matcheck)
	c:RegisterEffect(e0)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c284224.indtg)
	e1:SetValue(c284224.indct)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(284224,0))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c284224.thtg)
	e2:SetOperation(c284224.thop)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(284224,1))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_CHAINING)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,284224)
	e3:SetCondition(c284224.descon)
	e3:SetTarget(c284224.destg)
	e3:SetOperation(c284224.desop)
	c:RegisterEffect(e3)
end
function c284224.matcheck(e,c)
	local g=c:GetMaterial()
	if g:IsExists(Card.IsType,1,nil,TYPE_EFFECT) then
		c:RegisterFlagEffect(85360035,RESET_EVENT+RESETS_STANDARD-RESET_TOFIELD,0,1)
	end
end
function c284224.indtg(e,c)
	return c:IsSetCard(0x14f) and c:IsType(TYPE_FUSION)
end
function c284224.indct(e,re,r,rp)
	if bit.band(r,REASON_BATTLE)~=0 then
		return 1
	else return 0 end
end
function c284224.thfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand()
end
function c284224.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c284224.thfilter,tp,0,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(c284224.thfilter,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c284224.thop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c284224.thfilter,tp,0,LOCATION_ONFIELD,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
	end
end
function c284224.cfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_FUSION)
end
function c284224.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return ep==1-tp and re:GetHandler():IsOnField() and re:GetHandler():IsRelateToEffect(re) and re:IsActiveType(TYPE_MONSTER)
		and Duel.IsExistingMatchingCard(c284224.cfilter,tp,LOCATION_MZONE,0,2,nil)
end
function c284224.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return re:GetHandler():IsDestructable() end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
end
function c284224.desop(e,tp,eg,ep,ev,re,r,rp)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
