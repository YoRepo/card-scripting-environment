--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 终戒超兽-武尔德拉斯  (ID: 70636044)
-- Type: Monster / Effect / Xyz
-- Attribute: DARK
-- Race: Wyrm
-- Rank 10
-- ATK 3000 | DEF 3000
--
-- Effect Text:
-- 10星怪兽×2只以上
-- 这个卡名的①②③的效果1回合各能使用1次。
-- ①：对方把效果发动时，把这张卡1个超量素材取除才能发动。那个发动无效。那之后，可以把这张卡1个超量素材取除。那个场合，再把场上1张卡破坏。
-- ②：持有超量素材的这张卡攻击的伤害步骤开始时才能发动。场上1张卡破坏。
-- ③：超量召唤的这张卡被破坏的场合才能发动。场上1张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--終戒超獸－ヴァルドラス
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddXyzProcedure(c,nil,10,2,nil,nil,99)
	c:EnableReviveLimit()
	--
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,1))
	e1:SetCategory(CATEGORY_NEGATE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,id)
	e1:SetCondition(s.discon)
	e1:SetCost(s.discost)
	e1:SetTarget(s.distg)
	e1:SetOperation(s.disop)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_START)
	e2:SetCountLimit(1,id+o)
	e2:SetCondition(s.descon1)
	e2:SetTarget(s.destg)
	e2:SetOperation(s.desop)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,2))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetCountLimit(1,id+o*2)
	e3:SetCondition(s.descon2)
	e3:SetTarget(s.destg)
	e3:SetOperation(s.desop)
	c:RegisterEffect(e3)
end
function s.discon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and Duel.IsChainNegatable(ev)
		and ep==1-tp
end
function s.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function s.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end
function s.disop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.NegateActivation(ev) then
		if Duel.GetMatchingGroupCount(Card.IsOnField,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)>0
			and c:CheckRemoveOverlayCard(tp,1,REASON_EFFECT)
			and Duel.SelectYesNo(tp,aux.Stringid(id,3)) then
			Duel.BreakEffect()
			if c:RemoveOverlayCard(tp,1,1,REASON_EFFECT)~=0 then
				local g=Duel.SelectMatchingCard(tp,Card.IsOnField,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
				if #g>0 then
					Duel.BreakEffect()
					Duel.HintSelection(g)
					Duel.Destroy(g,REASON_EFFECT)
				end
			end
		end
	end
end
function s.descon1(e)
	local c=e:GetHandler()
	return c:GetOverlayCount()>0 and Duel.GetAttacker()==c
end
function s.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetFieldGroup(tp,LOCATION_ONFIELD,LOCATION_ONFIELD)
	if chk==0 then return #g>0 end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function s.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.GetFieldGroup(tp,LOCATION_ONFIELD,LOCATION_ONFIELD):Select(tp,1,1,nil)
	if #g>0 then
		Duel.HintSelection(g)
		Duel.Destroy(g,REASON_EFFECT)
	end
end
function s.descon2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_MZONE) and c:IsSummonType(SUMMON_TYPE_XYZ)
end
