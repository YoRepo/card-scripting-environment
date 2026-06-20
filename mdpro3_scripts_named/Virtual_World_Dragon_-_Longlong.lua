--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 电脑堺龙-龙龙  (ID: 61641818)
-- Type: Monster / Effect / Xyz
-- Attribute: EARTH
-- Race: Wyrm
-- Rank 3
-- ATK 2400 | DEF 2000
-- Setcode: 334
--
-- Effect Text:
-- 相同种族·属性的3星怪兽×2只以上
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：持有超量素材的这张卡不会成为对方的效果的对象。
-- ②：对方场上有表侧表示怪兽存在，对方把不在自身场上存在的属性的怪兽的效果发动时，把这张卡2个超量素材取除才能发动。那个发动无效。
--[[ __CARD_HEADER_END__ ]]

--電脳堺龍－龍々
function c61641818.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedureLevelFree(c,c61641818.mfilter,c61641818.xyzcheck,2,99)
	c:EnableReviveLimit()
	--cannot be effect target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e1:SetValue(aux.tgoval)
	e1:SetCondition(c61641818.etcon)
	c:RegisterEffect(e1)
	--negate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(61641818,0))
	e2:SetCategory(CATEGORY_NEGATE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,61641818)
	e2:SetCondition(c61641818.discon)
	e2:SetCost(c61641818.discost)
	e2:SetTarget(c61641818.distg)
	e2:SetOperation(c61641818.disop)
	c:RegisterEffect(e2)
end
function c61641818.mfilter(c,xyzc)
	return c:IsXyzType(TYPE_MONSTER) and c:IsXyzLevel(xyzc,3)
end
function c61641818.xyzcheck(g)
	return aux.SameValueCheck(g,Card.GetRace) and aux.SameValueCheck(g,Card.GetAttribute)
end
function c61641818.etcon(e)
	return e:GetHandler():GetOverlayCount()~=0
end
function c61641818.discon(e,tp,eg,ep,ev,re,r,rp)
	if ep==tp or e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) or not Duel.IsChainNegatable(ev) then return false end
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
	if g:GetCount()==0 or not re:IsActiveType(TYPE_MONSTER) then return false end
	local tc=g:GetFirst()
	local attr=0
	while tc do
		attr=attr|tc:GetAttribute()
		tc=g:GetNext()
	end
	local rattr=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_ATTRIBUTE)
	return rattr&attr==0
end
function c61641818.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,2,REASON_COST) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVEXYZ)
	e:GetHandler():RemoveOverlayCard(tp,2,2,REASON_COST)
end
function c61641818.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end
function c61641818.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
end
