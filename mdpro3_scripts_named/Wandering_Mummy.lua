--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 彷徨的木乃伊  (ID: 42994702)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Zombie
-- Level 4
-- ATK 1500 | DEF 1500
--
-- Effect Text:
-- 这张卡1个回合可以有1次变回里侧守备表示。这个效果使用后，把自己的主要怪兽区域的全部里侧守备表示的怪兽洗切，再次重新里侧守备表示按自己的顺序安排到场上的位置。
--[[ __CARD_HEADER_END__ ]]

--さまようミイラ
function c42994702.initial_effect(c)
	--turn set
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(42994702,0))
	e1:SetCategory(CATEGORY_POSITION+CATEGORY_MSET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c42994702.target)
	e1:SetOperation(c42994702.operation)
	c:RegisterEffect(e1)
end
function c42994702.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsCanTurnSet() and c:GetFlagEffect(42994702)==0 end
	c:RegisterFlagEffect(42994702,RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET+RESET_PHASE+PHASE_END,0,1)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,c,1,0,0)
end
function c42994702.filter(c)
	return c:IsFacedown() and c:GetSequence()<5
end
function c42994702.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() and Duel.ChangePosition(c,POS_FACEDOWN_DEFENSE)>0 then
		local g=Duel.GetMatchingGroup(c42994702.filter,tp,LOCATION_MZONE,0,nil)
		Duel.ShuffleSetCard(g)
	end
end
