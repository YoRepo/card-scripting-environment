--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 连接后退  (ID: 3567660)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：以额外怪兽区域1只自己的连接怪兽为对象才能发动。那只自己怪兽的位置向作为那所连接区的自己的主要怪兽区域移动。那之后，可以把那只怪兽的连接标记数量的卡从自己卡组上面送去墓地。
--[[ __CARD_HEADER_END__ ]]

--リンク・バック
function c3567660.initial_effect(c)
	--move
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,3567660+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c3567660.seqtg)
	e1:SetOperation(c3567660.seqop)
	c:RegisterEffect(e1)
end
function c3567660.filter(c,tp)
	if not (c:IsFaceup() and c:IsType(TYPE_LINK) and c:GetSequence()>=5) then return false end
	local zone=bit.band(c:GetLinkedZone(),0x1f)
	return Duel.GetLocationCount(tp,LOCATION_MZONE,PLAYER_NONE,0,zone)>0
end
function c3567660.seqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c3567660.filter(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c3567660.filter,tp,LOCATION_MZONE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(3567660,1))
	Duel.SelectTarget(tp,c3567660.filter,tp,LOCATION_MZONE,0,1,1,nil,tp)
end
function c3567660.seqop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not (tc:IsRelateToEffect(e) and tc:IsControler(tp)) then return end
	local zone=bit.band(tc:GetLinkedZone(tp),0x1f)
	if Duel.GetLocationCount(tp,LOCATION_MZONE,PLAYER_NONE,0,zone)>0 then
		local flag=bit.bxor(zone,0xff)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOZONE)
		local s=Duel.SelectDisableField(tp,1,LOCATION_MZONE,0,flag)
		local nseq=0
		if s==1 then nseq=0
		elseif s==2 then nseq=1
		elseif s==4 then nseq=2
		elseif s==8 then nseq=3
		else nseq=4 end
		Duel.MoveSequence(tc,nseq)
		local ct=tc:GetLink()
		if Duel.IsPlayerCanDiscardDeck(tp,ct) and Duel.SelectYesNo(tp,aux.Stringid(3567660,2)) then
			Duel.BreakEffect()
			Duel.DiscardDeck(tp,ct,REASON_EFFECT)
		end
	end
end
