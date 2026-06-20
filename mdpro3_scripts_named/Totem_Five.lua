--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 图腾五星  (ID: 56346071)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Rock
-- Level 3
-- ATK 500 | DEF 200
--
-- Effect Text:
-- ①：包含这张卡的5只怪兽同时特殊召唤成功的场合发动。对方场上的卡全部破坏，给与对方破坏数量×500伤害。
--[[ __CARD_HEADER_END__ ]]

--トーテム・ファイブ
function c56346071.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c56346071.descon)
	e1:SetTarget(c56346071.destg)
	e1:SetOperation(c56346071.desop)
	c:RegisterEffect(e1)
end
function c56346071.descon(e,tp,eg,ep,ev,re,r,rp)
	return eg:GetCount()==5 and eg:IsContains(e:GetHandler())
end
function c56346071.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,g:GetCount()*500)
end
function c56346071.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_ONFIELD,nil)
	Duel.Destroy(g,REASON_EFFECT)
	local sg=Duel.GetOperatedGroup()
	if sg:GetCount()>0 then
		Duel.Damage(1-tp,sg:GetCount()*500,REASON_EFFECT)
	end
end
