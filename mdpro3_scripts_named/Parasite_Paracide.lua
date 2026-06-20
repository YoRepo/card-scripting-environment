--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 寄生虫 帕拉赛德  (ID: 27911549)
-- Type: Monster / Effect / Toon
-- Attribute: EARTH
-- Race: Insect
-- Level 2
-- ATK 500 | DEF 300
--
-- Effect Text:
-- 反转：把这张卡表面向上混进对方卡组洗切。对方抽到这张卡时，这张卡在对方场上表侧守备表示特殊召唤，给与对方基本分1000分伤害。之后，只要这张卡表侧表示在场上存在，对方场上表侧表示存在的怪兽全部变成昆虫
-- 族。
--[[ __CARD_HEADER_END__ ]]

--寄生虫パラサイド
function c27911549.initial_effect(c)
	Duel.EnableGlobalFlag(GLOBALFLAG_DECK_REVERSE_CHECK)
	--to deck
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(27911549,0))
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c27911549.target)
	e1:SetOperation(c27911549.operation)
	c:RegisterEffect(e1)
end
function c27911549.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
end
function c27911549.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsStatus(STATUS_BATTLE_DESTROYED) then return end
	Duel.SendtoDeck(c,1-tp,SEQ_DECKSHUFFLE,REASON_EFFECT)
	if not c:IsLocation(LOCATION_DECK) then return end
	Duel.ShuffleDeck(1-tp)
	c:ReverseInDeck()
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(27911549,1))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_DRAW)
	e1:SetTarget(c27911549.sptg)
	e1:SetOperation(c27911549.spop)
	e1:SetReset(RESET_EVENT+0x1de0000)
	c:RegisterEffect(e1)
end
function c27911549.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsRelateToEffect(e) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c27911549.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		if Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP_DEFENSE)>0 then
			Duel.Damage(tp,1000,REASON_EFFECT)
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_FIELD)
			e1:SetCode(EFFECT_CHANGE_RACE)
			e1:SetRange(LOCATION_MZONE)
			e1:SetAbsoluteRange(tp,LOCATION_MZONE,0)
			e1:SetValue(RACE_INSECT)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			c:RegisterEffect(e1)
		end
	end
end
