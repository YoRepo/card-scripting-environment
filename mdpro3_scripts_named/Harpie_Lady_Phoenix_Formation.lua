--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 鹰身女郎 -凤凰之阵-  (ID: 86308219)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 100
--
-- Effect Text:
-- 这张卡发动的回合，自己不能从卡组·额外卡组把怪兽特殊召唤，不能进行战斗阶段。
-- ①：自己场上有「鹰身女郎」「鹰身女郎三姐妹」合计3只以上存在的场合，尽可能以最多有那个数量的对方场上的怪兽为对象才能发动。作为对象的怪兽破坏，给与对方破坏的怪兽之内原本攻击力最高的怪兽的那个数值的伤害
-- 。
--[[ __CARD_HEADER_END__ ]]

--ハーピィ・レディ －鳳凰の陣－
function c86308219.initial_effect(c)
	aux.AddCodeList(c,12206212)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c86308219.condition)
	e1:SetCost(c86308219.cost)
	e1:SetTarget(c86308219.target)
	e1:SetOperation(c86308219.activate)
	c:RegisterEffect(e1)
	Duel.AddCustomActivityCounter(86308219,ACTIVITY_SPSUMMON,c86308219.counterfilter)
end
function c86308219.counterfilter(c)
	return not c:IsSummonLocation(LOCATION_DECK+LOCATION_EXTRA)
end
function c86308219.cfilter(c)
	return c:IsFaceup() and c:IsCode(76812113,12206212)
end
function c86308219.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c86308219.cfilter,tp,LOCATION_MZONE,0,3,nil)
end
function c86308219.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCustomActivityCount(86308219,tp,ACTIVITY_SPSUMMON)==0
		and Duel.GetCurrentPhase()==PHASE_MAIN1 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c86308219.sumlimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e2:SetCode(EFFECT_CANNOT_BP)
	e2:SetTargetRange(1,0)
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)
end
function c86308219.sumlimit(e,c,sump,sumtype,sumpos,targetp)
	return c:IsLocation(LOCATION_DECK+LOCATION_EXTRA)
end
function c86308219.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,0,LOCATION_MZONE,1,nil) end
	local ct=Duel.GetMatchingGroupCount(c86308219.cfilter,tp,LOCATION_MZONE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,0,LOCATION_MZONE,ct,ct,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,0)
end
function c86308219.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if Duel.Destroy(g,REASON_EFFECT)~=0 then
		local og=Duel.GetOperatedGroup()
		local mg,matk=og:GetMaxGroup(Card.GetBaseAttack)
		if matk>0 then
			Duel.Damage(1-tp,matk,REASON_EFFECT)
		end
	end
end
