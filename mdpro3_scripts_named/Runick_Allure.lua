--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 神碑的欺诳  (ID: 29595202)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
-- Setcode: 383
--
-- Effect Text:
-- ①：「神碑的欺诳」在自己场上只能有1张表侧表示存在。
-- ②：每次自己或者对方把速攻魔法卡发动才发动。从对方卡组上面把1张卡除外。
--[[ __CARD_HEADER_END__ ]]

--神碑の誑かし
function c29595202.initial_effect(c)
	c:SetUniqueOnField(1,0,29595202)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--remove
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(29595202,0))
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c29595202.rmcon)
	e2:SetTarget(c29595202.rmtg)
	e2:SetOperation(c29595202.rmop)
	c:RegisterEffect(e2)
end
function c29595202.rmcon(e,tp,eg,ep,ev,re,r,rp)
	return re:IsActiveType(TYPE_QUICKPLAY) and re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c29595202.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,1-tp,LOCATION_DECK)
end
function c29595202.rmop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)==0 then return end
	local g=Duel.GetDecktopGroup(1-tp,1)
	Duel.DisableShuffleCheck()
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
end
