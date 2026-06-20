--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 沙尘之恶灵  (ID: 89111398)
-- Type: Monster / Effect / Spirit
-- Attribute: EARTH
-- Race: Zombie
-- Level 6
-- ATK 2200 | DEF 1800
--
-- Effect Text:
-- 这张卡不能特殊召唤。召唤·反转的回合的结束阶段时回到主人的手卡。这张卡召唤·反转时，场上的这张卡以外的全部表侧表示的怪兽破坏。
--[[ __CARD_HEADER_END__ ]]

--砂塵の悪霊
function c89111398.initial_effect(c)
	--spirit
	aux.EnableSpiritReturn(c,EVENT_SUMMON_SUCCESS,EVENT_FLIP)
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)
	--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(89111398,1))
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_SUMMON_SUCCESS)
	e4:SetTarget(c89111398.destg)
	e4:SetOperation(c89111398.desop)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EVENT_FLIP)
	c:RegisterEffect(e5)
end
function c89111398.filter(c)
	return c:IsFaceup()
end
function c89111398.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c89111398.filter,tp,LOCATION_MZONE,LOCATION_MZONE,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c89111398.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c89111398.filter,tp,LOCATION_MZONE,LOCATION_MZONE,aux.ExceptThisCard(e))
	Duel.Destroy(g,REASON_EFFECT)
end
