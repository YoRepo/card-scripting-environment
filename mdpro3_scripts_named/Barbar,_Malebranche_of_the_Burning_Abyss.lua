--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 彼岸的恶鬼 巴尔巴里恰  (ID: 81992475)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 3
-- ATK 1700 | DEF 1000
-- Setcode: 177
--
-- Effect Text:
-- 「彼岸的恶鬼 巴尔巴里恰」的①③的效果1回合只能有1次使用其中任意1个。
-- ①：自己场上没有魔法·陷阱卡存在的场合才能发动。这张卡从手卡特殊召唤。
-- ②：自己场上有「彼岸」怪兽以外的怪兽存在的场合这张卡破坏。
-- ③：这张卡被送去墓地的场合，以「彼岸的恶鬼 巴尔巴里恰」以外的自己墓地最多3张「彼岸」卡为对象才能发动。那些卡除外，给与对方除外数量×300伤害。
--[[ __CARD_HEADER_END__ ]]

--彼岸の悪鬼 バルバリッチャ
function c81992475.initial_effect(c)
	--self destroy
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_SELF_DESTROY)
	e1:SetCondition(c81992475.sdcon)
	c:RegisterEffect(e1)
	--Special Summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(81992475,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_HAND)
	e2:SetCountLimit(1,81992475)
	e2:SetCondition(c81992475.sscon)
	e2:SetTarget(c81992475.sstg)
	e2:SetOperation(c81992475.ssop)
	c:RegisterEffect(e2)
	--remove
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(81992475,1))
	e3:SetCategory(CATEGORY_REMOVE+CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCountLimit(1,81992475)
	e3:SetTarget(c81992475.rmtg)
	e3:SetOperation(c81992475.rmop)
	c:RegisterEffect(e3)
end
function c81992475.sdfilter(c)
	return c:IsFacedown() or not c:IsSetCard(0xb1)
end
function c81992475.sdcon(e)
	return Duel.IsExistingMatchingCard(c81992475.sdfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c81992475.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c81992475.sscon(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c81992475.filter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c81992475.sstg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c81992475.ssop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
function c81992475.rmfilter(c)
	return c:IsSetCard(0xb1) and not c:IsCode(81992475) and c:IsAbleToRemove()
end
function c81992475.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c81992475.rmfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c81992475.rmfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c81992475.rmfilter,tp,LOCATION_GRAVE,0,1,3,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),tp,LOCATION_GRAVE)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,g:GetCount()*300)
end
function c81992475.rmop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if g:GetCount()>0 and Duel.Remove(g,POS_FACEUP,REASON_EFFECT)~=0 then
		local rg=Duel.GetOperatedGroup()
		local ct=rg:FilterCount(Card.IsLocation,nil,LOCATION_REMOVED)
		if ct>0 then
			Duel.Damage(1-tp,ct*300,REASON_EFFECT)
		end
	end
end
