--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 龙辉巧-扶筐增二μβ'  (ID: 1174075)
-- Type: Monster / Effect / Xyz
-- Attribute: LIGHT
-- Race: Machine
-- Rank 1
-- ATK 2000 | DEF 0
-- Setcode: 340
--
-- Effect Text:
-- 1星怪兽×2只以上
-- 这个卡名的①③的效果1回合各能使用1次。
-- ①：这张卡超量召唤的场合才能发动。从卡组把1张「龙辉巧」卡送去墓地。
-- ②：自己进行仪式召唤的场合，也能把那些解放的怪兽从这张卡的超量素材取除。
-- ③：自己场上有机械族仪式怪兽存在，对方把魔法·陷阱卡发动时，把这张卡1个超量素材取除才能发动。那个发动无效并破坏。
--[[ __CARD_HEADER_END__ ]]

--竜輝巧－ファフμβ’
function c1174075.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddXyzProcedure(c,nil,1,2,nil,nil,99)
	--tograve
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(1174075,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,1174075)
	e1:SetCondition(c1174075.tgcon)
	e1:SetTarget(c1174075.tgtg)
	e1:SetOperation(c1174075.tgop)
	c:RegisterEffect(e1)
	--extra material
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_OVERLAY_RITUAL_MATERIAL)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--negate
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(1174075,1))
	e3:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_CHAINING)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,1174076)
	e3:SetCondition(c1174075.discon)
	e3:SetCost(c1174075.discost)
	e3:SetTarget(c1174075.distg)
	e3:SetOperation(c1174075.disop)
	c:RegisterEffect(e3)
end
function c1174075.tgcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_XYZ)
end
function c1174075.tgfilter(c)
	return c:IsSetCard(0x154) and c:IsAbleToGrave()
end
function c1174075.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c1174075.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c1174075.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c1174075.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
function c1174075.cfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_RITUAL) and c:IsRace(RACE_MACHINE)
end
function c1174075.discon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and Duel.IsChainNegatable(ev)
		and ep==1-tp and re:IsHasType(EFFECT_TYPE_ACTIVATE)
		and Duel.IsExistingMatchingCard(c1174075.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c1174075.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c1174075.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c1174075.disop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
