--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 鬼计骷髅  (ID: 51196805)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Zombie
-- Level 3
-- ATK 1200 | DEF 1100
-- Setcode: 141
--
-- Effect Text:
-- 自己场上有名字带有「鬼计」的怪兽存在的场合才能让这张卡表侧表示召唤。这张卡1回合只有1次可以变成里侧守备表示。此外，这张卡反转时，把最多有自己场上的名字带有「鬼计」的怪兽数量的卡从对方卡组上面里侧表示
-- 除外。「鬼计骷髅」的这个效果1回合只能使用1次。
--[[ __CARD_HEADER_END__ ]]

--ゴーストリック・スケルトン
function c51196805.initial_effect(c)
	--summon limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_SUMMON)
	e1:SetCondition(c51196805.sumcon)
	c:RegisterEffect(e1)
	--turn set
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(51196805,0))
	e2:SetCategory(CATEGORY_POSITION+CATEGORY_MSET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c51196805.postg)
	e2:SetOperation(c51196805.posop)
	c:RegisterEffect(e2)
	--banish
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(51196805,1))
	e3:SetCategory(CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCountLimit(1,51196805)
	e3:SetCode(EVENT_FLIP)
	e3:SetTarget(c51196805.rmtg)
	e3:SetOperation(c51196805.rmop)
	c:RegisterEffect(e3)
end
function c51196805.sfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x8d)
end
function c51196805.sumcon(e)
	return not Duel.IsExistingMatchingCard(c51196805.sfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c51196805.postg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsCanTurnSet() and c:GetFlagEffect(51196805)==0 end
	c:RegisterFlagEffect(51196805,RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET+RESET_PHASE+PHASE_END,0,1)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,c,1,0,0)
end
function c51196805.posop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		Duel.ChangePosition(c,POS_FACEDOWN_DEFENSE)
	end
end
function c51196805.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,1-tp,LOCATION_DECK)
end
function c51196805.rmop(e,tp,eg,ep,ev,re,r,rp)
	local ct1=Duel.GetMatchingGroupCount(c51196805.sfilter,tp,LOCATION_MZONE,0,nil)
	local ct2=Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)
	if ct1>ct2 then ct1=ct2 end
	if ct1==0 then return end
	local t={}
	for i=1,ct1 do t[i]=i end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(51196805,2))
	local ac=Duel.AnnounceNumber(tp,table.unpack(t))
	local g=Duel.GetDecktopGroup(1-tp,ac)
	Duel.DisableShuffleCheck()
	Duel.Remove(g,POS_FACEDOWN,REASON_EFFECT)
end
