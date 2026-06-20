--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 梦幻崩影·地狱犬  (ID: 75452921)
-- Type: Monster / Effect / Link
-- Attribute: EARTH
-- Race: Fiend
-- ATK 1600 | LINK
-- Setcode: 274
--
-- Effect Text:
-- 卡名不同的怪兽2只
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：这张卡连接召唤的场合，丢弃1张手卡，以对方的主要怪兽区域1只特殊召唤的怪兽为对象才能发动。那只怪兽破坏。这个效果的发动时这张卡是互相连接状态的场合，再让自己可以抽1张。
-- ②：只要这张卡在怪兽区域存在，自己场上的互相连接状态的怪兽不会被效果破坏。
--[[ __CARD_HEADER_END__ ]]

--トロイメア・ケルベロス
function c75452921.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,nil,2,2,c75452921.lcheck)
	c:EnableReviveLimit()
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(75452921,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,75452921)
	e1:SetCondition(c75452921.descon)
	e1:SetCost(c75452921.descost)
	e1:SetTarget(c75452921.destg)
	e1:SetOperation(c75452921.desop)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c75452921.indtg)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
function c75452921.lcheck(g,lc)
	return g:GetClassCount(Card.GetLinkCode)==g:GetCount()
end
function c75452921.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_LINK)
end
function c75452921.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c75452921.desfilter(c)
	return c:IsSummonType(SUMMON_TYPE_SPECIAL) and c:GetSequence()<5
end
function c75452921.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and c75452921.desfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c75452921.desfilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c75452921.desfilter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	if e:GetHandler():GetMutualLinkedGroupCount()>0 then
		e:SetCategory(CATEGORY_DESTROY+CATEGORY_DRAW)
		e:SetLabel(1)
	else
		e:SetCategory(CATEGORY_DESTROY)
		e:SetLabel(0)
	end
end
function c75452921.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)~=0
		and e:GetLabel()==1 and Duel.IsPlayerCanDraw(tp,1)
		and Duel.SelectYesNo(tp,aux.Stringid(75452921,1)) then
		Duel.BreakEffect()
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
function c75452921.indtg(e,c)
	return c:GetMutualLinkedGroupCount()>0
end
