--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 阿努比斯的审判  (ID: 59576447)
-- Type: Trap / Flip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：自己场上有其他的魔法·陷阱卡3张以上存在，对方把魔法·陷阱卡发动时才能发动。那个发动无效并破坏。自己场上有「王家的神殿」存在的场合，可以再把对方场上的怪兽全部破坏。那个场合，再给与对方破坏的怪兽的
-- 原本攻击力合计数值一半的伤害。
--[[ __CARD_HEADER_END__ ]]

--アヌビスの審判
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,29762407)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(s.condition)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
function s.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_ONFIELD,0,3,e:GetHandler(),TYPE_SPELL+TYPE_TRAP) and rp==1-tp
		and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsRelateToEffect(re) then Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0) end
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) and Duel.Destroy(eg,REASON_EFFECT)~=0 then
		local sg=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
		if #sg>0 and Duel.IsExistingMatchingCard(aux.AND(Card.IsFaceup,Card.IsCode),tp,LOCATION_ONFIELD,0,1,nil,29762407)
			and Duel.SelectYesNo(tp,aux.Stringid(id,1)) then
			Duel.BreakEffect()
			if Duel.Destroy(sg,REASON_EFFECT)~=0 then
				local og=Duel.GetOperatedGroup()
				local atk=math.ceil(og:GetSum(Card.GetTextAttack)/2)
				Duel.Damage(1-tp,atk,REASON_EFFECT)
			end
		end
	end
end
