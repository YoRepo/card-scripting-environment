--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 试号闪刀姬-天津  (ID: 25072579)
-- Type: Monster / Effect / Link
-- Attribute: DARK
-- Race: Machine
-- ATK 1500 | LINK
-- Setcode: 4373
--
-- Effect Text:
-- 「闪刀姬」怪兽1只
-- 自己对「试号闪刀姬-天津」1回合只能有1次特殊召唤，那些①②的效果1回合各能使用1次。
-- ①：对方场上的攻击力2000以上的怪兽把效果发动时才能发动。那个效果变成「对方场上1只「闪刀姬」连接怪兽破坏」。
-- ②：这张卡和对方怪兽进行战斗的攻击宣言时，以自己场上1只「闪刀姬」怪兽和对方场上1张卡为对象才能发动。那些卡破坏。
--[[ __CARD_HEADER_END__ ]]

--試号閃刀姫－アマツ
local s,id,o=GetID()
function s.initial_effect(c)
	c:SetSPSummonOnce(id)
	--material
	aux.AddLinkProcedure(c,s.matfilter,1,1)
	c:EnableReviveLimit()
	--change effect
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,id)
	e1:SetCondition(s.chcon)
	e1:SetTarget(s.chtg)
	e1:SetOperation(s.chop)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,id+o)
	e2:SetCondition(s.descon)
	e2:SetTarget(s.destg)
	e2:SetOperation(s.desop)
	c:RegisterEffect(e2)
end
function s.matfilter(c)
	return c:IsLinkSetCard(0x1115)
end
function s.chcon(e,tp,eg,ep,ev,re,r,rp)
	local p,loc,atk=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_PLAYER,CHAININFO_TRIGGERING_LOCATION,CHAININFO_TRIGGERING_ATTACK)
	return p==1-tp and (LOCATION_ONFIELD&loc)~=0 and re:IsActiveType(TYPE_MONSTER) and atk>=2000
end
function s.desfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x1115) and c:IsType(TYPE_LINK)
end
function s.chtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.desfilter,rp,0,LOCATION_MZONE,1,nil) end
end
function s.chop(e,tp,eg,ep,ev,re,r,rp)
	local g=Group.CreateGroup()
	Duel.ChangeTargetCard(ev,g)
	Duel.ChangeChainOperation(ev,s.repop)
end
function s.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,s.desfilter,tp,0,LOCATION_MZONE,1,1,nil)
	if #g>0 then
		Duel.HintSelection(g)
		Duel.Destroy(g,REASON_EFFECT)
	end
end
function s.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ac=c:GetBattleTarget()
	e:SetLabelObject(ac)
	return ac and ac:IsControler(1-tp)
end
function s.desfilter2(c)
	return c:IsFaceup() and c:IsSetCard(0x1115)
end
function s.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(s.desfilter2,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingTarget(aux.TRUE,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g1=Duel.SelectTarget(tp,s.desfilter2,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g2=Duel.SelectTarget(tp,aux.TRUE,tp,0,LOCATION_ONFIELD,1,1,nil)
	g1:Merge(g2)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g1,2,0,0)
end
function s.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tg=g:Filter(Card.IsRelateToChain,nil)
	if tg:GetCount()>0 then
		Duel.Destroy(tg,REASON_EFFECT)
	end
end
