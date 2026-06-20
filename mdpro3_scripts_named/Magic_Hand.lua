--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 魔术手  (ID: 22530212)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level 4
-- ATK 800 | DEF 1600
--
-- Effect Text:
-- ①：只在这张卡在场上表侧表示存在才有1次，对方用抽卡以外的方法从卡组把卡加入手卡时才能发动。那卡送去墓地，给与对方800伤害。
--[[ __CARD_HEADER_END__ ]]

--マジック・ハンド
function c22530212.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_TO_HAND)
	e1:SetCountLimit(1)
	e1:SetCondition(c22530212.condition)
	e1:SetTarget(c22530212.target)
	e1:SetOperation(c22530212.activate)
	c:RegisterEffect(e1)
end
function c22530212.cfilter(c,tp)
	return c:IsControler(tp) and c:IsPreviousLocation(LOCATION_DECK) and not c:IsReason(REASON_DRAW)
end
function c22530212.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c22530212.cfilter,1,nil,1-tp)
end
function c22530212.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=eg:Filter(c22530212.cfilter,nil,1-tp)
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,800)
end
function c22530212.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if g:GetCount()~=0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
		if g:IsExists(Card.IsLocation,1,nil,LOCATION_GRAVE) then
			Duel.Damage(1-tp,800,REASON_EFFECT)
		end
	end
end
