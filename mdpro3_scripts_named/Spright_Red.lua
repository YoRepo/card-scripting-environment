--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 卫星闪灵·红色精灵  (ID: 75922381)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Thunder
-- Level 2
-- ATK 1200 | DEF 1800
-- Setcode: 384
--
-- Effect Text:
-- 这个卡名的①的方法的特殊召唤1回合只能有1次，②的效果1回合只能使用1次。
-- ①：自己场上有2星或连接2的怪兽存在的场合，这张卡可以从手卡特殊召唤。
-- ②：对方把怪兽的效果发动时，把自己场上1只其他的2星·2阶·连接2的怪兽解放才能发动。那个效果无效。把2阶或连接2的怪兽解放发动的场合，可以再把那只无效的怪兽破坏。
--[[ __CARD_HEADER_END__ ]]

--スプライト・レッド
function c75922381.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(75922381,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,75922381+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c75922381.spcon)
	c:RegisterEffect(e1)
	--disable
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(75922381,1))
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_DISABLE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetCountLimit(1,75922382)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c75922381.discon)
	e2:SetCost(c75922381.discost)
	e2:SetTarget(c75922381.distg)
	e2:SetOperation(c75922381.disop)
	c:RegisterEffect(e2)
end
function c75922381.filter(c)
	return (c:IsLevel(2) or c:IsLink(2)) and c:IsFaceup()
end
function c75922381.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c75922381.filter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
function c75922381.discon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and re:IsActiveType(TYPE_MONSTER) and Duel.IsChainDisablable(ev)
end
function c75922381.cfilter(c)
	return c:IsLevel(2) or c:IsRank(2) or c:IsLink(2)
end
function c75922381.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c75922381.cfilter,1,e:GetHandler()) end
	local g=Duel.SelectReleaseGroup(tp,c75922381.cfilter,1,1,e:GetHandler())
	Duel.Release(g,REASON_COST)
	local tc=Duel.GetOperatedGroup():GetFirst()
	e:SetLabelObject(tc)
end
function c75922381.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
end
function c75922381.disop(e,tp,eg,ep,ev,re,r,rp)
	local rc=re:GetHandler()
	if Duel.NegateEffect(ev) and rc:IsRelateToEffect(re) and rc:IsDestructable()
		and (e:GetLabelObject():IsRank(2) or e:GetLabelObject():IsLink(2))
		and Duel.SelectYesNo(tp,aux.Stringid(75922381,2)) then
		Duel.BreakEffect()
		Duel.Destroy(rc,REASON_EFFECT)
	end
end
