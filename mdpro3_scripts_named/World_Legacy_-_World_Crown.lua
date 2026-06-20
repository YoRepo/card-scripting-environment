--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 星遗物-『星冠』  (ID: 27918365)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level 6
-- ATK 2000 | DEF 2000
-- Setcode: 254
--
-- Effect Text:
-- 这个卡名的①的方法的特殊召唤1回合只能有1次，③的效果1回合只能使用1次。
-- ①：这张卡可以从手卡往作为连接怪兽所连接区的自己场上守备表示特殊召唤。
-- ②：从额外卡组特殊召唤的场上的怪兽的效果发动时，把这张卡解放才能发动。那个发动无效并破坏。
-- ③：通常召唤的这张卡被解放的场合才能发动。从卡组把1张「星遗物」魔法·陷阱卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--星遺物－『星冠』
function c27918365.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(27918365,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SPSUM_PARAM)
	e1:SetRange(LOCATION_HAND)
	e1:SetTargetRange(POS_FACEUP_DEFENSE,0)
	e1:SetCountLimit(1,27918365+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c27918365.spcon)
	e1:SetValue(c27918365.spval)
	c:RegisterEffect(e1)
	--negate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(27918365,1))
	e2:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c27918365.negcon)
	e2:SetCost(c27918365.negcost)
	e2:SetTarget(c27918365.negtg)
	e2:SetOperation(c27918365.negop)
	c:RegisterEffect(e2)
	--to hand
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(27918365,2))
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_RELEASE)
	e3:SetCountLimit(1,27918366)
	e3:SetCondition(c27918365.thcon)
	e3:SetTarget(c27918365.thtg)
	e3:SetOperation(c27918365.thop)
	c:RegisterEffect(e3)
end
function c27918365.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local zone=Duel.GetLinkedZone(tp)
	return Duel.GetLocationCount(tp,LOCATION_MZONE,tp,LOCATION_REASON_TOFIELD,zone)>0
end
function c27918365.spval(e,c)
	return 0,Duel.GetLinkedZone(c:GetControler())
end
function c27918365.negcon(e,tp,eg,ep,ev,re,r,rp)
	local loc=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and re:IsActiveType(TYPE_MONSTER) and re:GetHandler():IsSummonLocation(LOCATION_EXTRA) and loc==LOCATION_MZONE
		and Duel.IsChainNegatable(ev)
end
function c27918365.negcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c27918365.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c27918365.negop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
function c27918365.thfilter(c)
	return c:IsSetCard(0xfe) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand()
end
function c27918365.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_NORMAL)
end
function c27918365.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c27918365.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c27918365.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c27918365.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
