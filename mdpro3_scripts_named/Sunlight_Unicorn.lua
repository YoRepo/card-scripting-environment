--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 日光独角兽  (ID: 10321588)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Beast
-- Level 4
-- ATK 1800 | DEF 1000
--
-- Effect Text:
-- 1回合1次，自己的主要阶段时才能发动。把自己卡组最上面的卡翻开，那是装备魔法卡的场合加入手卡。不是的场合，回到自己卡组最下面。
--[[ __CARD_HEADER_END__ ]]

--サンライト・ユニコーン
function c10321588.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10321588,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c10321588.target)
	e1:SetOperation(c10321588.operation)
	c:RegisterEffect(e1)
end
function c10321588.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 end
end
function c10321588.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	Duel.ConfirmDecktop(tp,1)
	local g=Duel.GetDecktopGroup(tp,1)
	local tc=g:GetFirst()
	if tc:IsType(TYPE_EQUIP) and tc:IsAbleToHand() then
		Duel.DisableShuffleCheck()
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ShuffleHand(tp)
	else
		Duel.MoveSequence(tc,SEQ_DECKBOTTOM)
	end
end
