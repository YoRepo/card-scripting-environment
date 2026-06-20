--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 锁龙蛇-骷髅四面鬼  (ID: 74997493)
-- Type: Monster / Effect / Link
-- Attribute: EARTH
-- Race: Dragon
-- ATK 2800 | LINK
--
-- Effect Text:
-- 卡名不同的怪兽2只以上
-- ①：这张卡得到作为这张卡的连接素材的怪兽数量的以下效果。
-- ●2只以上：这张卡所连接区有怪兽召唤·特殊召唤的场合发动。那些怪兽的攻击力·守备力上升300。
-- ●3只以上：1回合1次，自己主要阶段才能发动。从手卡把1只怪兽特殊召唤。
-- ●4只：这张卡连接召唤时才能发动。自己抽4张。那之后，选自己3张手卡用喜欢的顺序回到卡组下面。
--[[ __CARD_HEADER_END__ ]]

--鎖龍蛇－スカルデット
function c74997493.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,nil,2,nil,c74997493.lcheck)
	c:EnableReviveLimit()
	--effect gain
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c74997493.regcon)
	e2:SetOperation(c74997493.regop)
	c:RegisterEffect(e2)
	--draw
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(74997493,2))
	e3:SetCategory(CATEGORY_DRAW)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCondition(c74997493.drcon)
	e3:SetTarget(c74997493.drtg)
	e3:SetOperation(c74997493.drop)
	c:RegisterEffect(e3)
end
function c74997493.lcheck(g,lc)
	return g:GetClassCount(Card.GetLinkCode)==g:GetCount()
end
function c74997493.regcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_LINK)
end
function c74997493.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetMaterialCount()>=2 then
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(74997493,0))
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
		e1:SetProperty(EFFECT_FLAG_DELAY)
		e1:SetCode(EVENT_SUMMON_SUCCESS)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCondition(c74997493.atkcon)
		e1:SetOperation(c74997493.atkop)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EVENT_SPSUMMON_SUCCESS)
		c:RegisterEffect(e2)
		c:RegisterFlagEffect(0,RESET_EVENT+RESETS_STANDARD,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(74997493,3))
	end
	if c:GetMaterialCount()>=3 then
		local e3=Effect.CreateEffect(c)
		e3:SetDescription(aux.Stringid(74997493,1))
		e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
		e3:SetType(EFFECT_TYPE_IGNITION)
		e3:SetRange(LOCATION_MZONE)
		e3:SetCountLimit(1)
		e3:SetTarget(c74997493.sptg)
		e3:SetOperation(c74997493.spop)
		e3:SetReset(RESET_EVENT+RESETS_STANDARD)
		c:RegisterEffect(e3)
		c:RegisterFlagEffect(0,RESET_EVENT+RESETS_STANDARD,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(74997493,4))
	end
end
function c74997493.cfilter(c,g)
	return c:IsFaceup() and g:IsContains(c)
end
function c74997493.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local lg=e:GetHandler():GetLinkedGroup()
	return lg and eg:IsExists(c74997493.cfilter,1,nil,lg)
end
function c74997493.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local lg=c:GetLinkedGroup()
	if not lg then return end
	local g=eg:Filter(c74997493.cfilter,nil,lg)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(300)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		tc:RegisterEffect(e2)
		tc=g:GetNext()
	end
end
function c74997493.spfilter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c74997493.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c74997493.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c74997493.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c74997493.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c74997493.drcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsSummonType(SUMMON_TYPE_LINK) and c:GetMaterialCount()==4
end
function c74997493.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,4) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(4)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,4)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,0,tp,3)
end
function c74997493.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	if Duel.Draw(p,d,REASON_EFFECT)==4 then
		local g=Duel.GetMatchingGroup(Card.IsAbleToDeck,p,LOCATION_HAND,0,nil)
		if g:GetCount()<3 then return end
		Duel.ShuffleHand(p)
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,p,HINTMSG_TODECK)
		local sg=g:Select(p,3,3,nil)
		aux.PlaceCardsOnDeckBottom(p,sg)
	end
end
