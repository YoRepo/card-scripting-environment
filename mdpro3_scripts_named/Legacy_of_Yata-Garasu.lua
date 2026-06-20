--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 八汰乌之骸  (ID: 30461781)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 从下面效果选择1个发动。
-- ●从自己卡组抽1张卡。
-- ●对方场上有灵魂怪兽表侧表示存在的场合才能发动。从自己卡组抽2张卡。
--[[ __CARD_HEADER_END__ ]]

--八汰烏の骸
function c30461781.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c30461781.target)
	e1:SetOperation(c30461781.activate)
	c:RegisterEffect(e1)
end
c30461781.has_text_type=TYPE_SPIRIT
function c30461781.filter(c)
	return c:IsType(TYPE_SPIRIT) and c:IsFaceup()
end
function c30461781.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	local d=1
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>1
		and Duel.IsExistingMatchingCard(c30461781.filter,tp,0,LOCATION_MZONE,1,nil)
		and Duel.SelectOption(tp,aux.Stringid(30461781,0),aux.Stringid(30461781,1))==1 then
		d=2
	end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(d)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,d)
end
function c30461781.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
